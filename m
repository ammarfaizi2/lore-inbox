Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUF2ScY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUF2ScY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUF2ScY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:32:24 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:46388 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265905AbUF2Sbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:31:55 -0400
Date: Tue, 29 Jun 2004 13:31:53 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Oliver Neukum <oliver@neukum.org>, scott@timesys.com, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net, Robert White <rwhite@casabyte.com>
Subject: Re: drivers/block/ub.c
Message-ID: <20040629183153.GA11558@hexapodia.org>
References: <20040628132531.036281b0.davem@redhat.com> <200406282257.11026.oliver@neukum.org> <20040628140343.572a0944.davem@redhat.com> <20040628211857.GA5508@yoda.timesys> <20040628152208.20fe97f1.davem@redhat.com> <20040626130645.55be13ce@lembas.zaitcev.lan> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com> <200406282257.11026.oliver@neukum.org> <20040628140343.572a0944.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040628191545.7a298bc3.davem@redhat.com> <20040628152208.20fe97f1.davem@redhat.com> <20040628140343.572a0944.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, you seem to be arguing "This is how __packed__ works, therefore
this is how __packed__ works, therefore anything else is now how
__packed__ works".  Oliver is trying to propose *new* semantics which
*differ* from __packed__ in a way that seems useful.

On Mon, Jun 28, 2004 at 02:03:43PM -0700, David S. Miller wrote:
> On Mon, 28 Jun 2004 22:57:11 +0200
> Oliver Neukum <oliver@neukum.org> wrote:
> > Am Montag, 28. Juni 2004 22:25 schrieb David S. Miller:
> > > That's true.  But if one were to propose such a feature to the gcc
> > > guys, I know the first question they would ask.  "If no padding of
> > > the structure is needed, why are you specifying this new
> > > __nopadding__ attribute?"
> > 
> > It would replace some uses of __packed__, where the first element
> > is aligned.
> 
> You have not considered what is supposed to happen when this
> structure is embedded within another one.  What kind of alignment
> rules apply in that case?  For example:
> 
> struct foo { u32 x; u8 y; u16 z; } __attribute__((__packed__));
> struct bar { u8  a; struct foo  b; };
> 
> That is why __packed__ can't assume the alignment of any structure
> instance whatsoever.  Your __nopadding__ attribute proposal would
> lay out struct bar differently in order to meet the alignment guarentees
> you say it will be able to meet.


Here's Oliver's suggestion, as I understand it:
 - a __nopadding__ struct is naturally aligned for its first member.
 - The compiler does not insert alignment into a __nopadding__ struct.
 - From the outside, a __nopadding__ struct does not differ from a
   normal struct (one lacking all attribute()s), except in its size.  So
   your "struct foo" above (with __nopadding__) would be 7 bytes with
   4-byte alignment for the u32.

As proposed, __nopadding__ is better than __packed__ because leading
correctly-aligned elements can be accessed directly with aligned loads
rather than requiring byte-at-a-time loads on platforms such as SPARC.

To answer your question:  a __nopadding__ struct embedded in another
struct will be naturally aligned just as a normal struct with the same
members would have been.  (Possible variation:  align it as necessary
for the first member, treat the rest as "bag 'o bits".)

It's unfortunate that GCC has conflated several not-necessarily-related
features into a single switch.

 1. no padding between elements
 2. no alignment internally
 3. no alignment externally

This results in confusion, as Scott shows below.  Worse, poorly-defined
semantics are a likely source of implementation bugs -- are you
confident that every aspect of __packed__ works the same in every
compiler that understands attribute((packed))?  Including ICC and
gcc-2.6.0?

On Mon, Jun 28, 2004 at 03:22:08PM -0700, David S. Miller wrote:
> On Mon, 28 Jun 2004 17:18:57 -0400
> Scott Wood <scott@timesys.com> wrote:
> > On Mon, Jun 28, 2004 at 02:03:43PM -0700, David S. Miller wrote:
> > > struct foo { u32 x; u8 y; u16 z; } __attribute__((__packed__));
> > > struct bar { u8  a; struct foo  b; };
> > 
> > As long as bar is not packed, why shouldn't the beginning of bar.b be
> > aligned?
> 
> No!  bar.b starts at offset 1 byte.  That's how this stuff works.
> 
> This is exactly why you cannot assume the alignment of any structure
> which is given attribute __packed__.  The example above shows that
> quite clearly.

-andy
