Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTJAXmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbTJAXmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:42:39 -0400
Received: from waste.org ([209.173.204.2]:16307 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262671AbTJAXmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:42:38 -0400
Date: Wed, 1 Oct 2003 18:42:19 -0500
From: Matt Mackall <mpm@selenic.com>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: Steve French <sfrench@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031001234219.GM1897@waste.org>
References: <20030902203041.GA25675@johanna5.ux.his.no> <20031001133039.GA32610@badne3.ux.his.no> <20031001195522.GK1897@waste.org> <20031001232650.GB18028@badne3.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001232650.GB18028@badne3.ux.his.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 01:26:50AM +0200, Erlend Aasland wrote:
> On 10/01/03 14:55, Matt Mackall wrote:
> > On Wed, Oct 01, 2003 at 03:30:39PM +0200, Erlend Aasland wrote:
> > >  static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu, const char * key, char * signature)
> > [...]
> > Eek. How often does this get called?
> It is (normally) called twice in SendReceive(). SendReceive() is called
> very often in cifs. After a quick look at cifs, it seems that most of
> these calls are protected with a per connection-lock (correct me if I'm
> wrong). But since two connections can call SendReceive() at the same
> time, we have to protect the tfm with locks. Correct?

Correct. But this lock is going to be a huge bottleneck.

> Would a better solution be to allocate one tfm per connection, thus
> no need to protect the tfm with a dedicated lock, right?

Per connection sounds like a much better answer, assuming you can
guarantee that SendReceive() never gets called simultaneously on the
same connection.

> [Or is converting cifs to the cryptoapi is waste of time? (I hope not :-) ]

No, it's generally a good idea, but the allocation of tfms means that
conversion isn't necessarily straightforward.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
