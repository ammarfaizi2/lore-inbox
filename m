Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTJHIk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 04:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTJHIk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 04:40:56 -0400
Received: from fmr05.intel.com ([134.134.136.6]:58816 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261159AbTJHIky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 04:40:54 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] incorrect use of sizeof() in ioctl definitions
Date: Wed, 8 Oct 2003 16:40:46 +0800
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8F3283B@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] incorrect use of sizeof() in ioctl definitions
Thread-Index: AcOHs4XoK9QAuwezQsqz1nwTtB99fwFvRU1g
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Andrew Morton" <akpm@osdl.org>, "Sharma, Arun" <arun.sharma@intel.com>,
       <linux-kernel@vger.kernel.org>, "Matthew Wilcox" <willy@debian.org>
X-OriginalArrivalTime: 08 Oct 2003 08:40:47.0427 (UTC) FILETIME=[DEC03930:01C38D77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andries Brouwer [mailto:aebr@win.tue.nl] wrote:
> On Tue, Sep 30, 2003 at 11:25:56PM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 30, 2003 at 02:08:05PM -0700, Andrew Morton wrote:
> > > Arun Sharma <arun.sharma@intel.com> wrote:
> > > >
> > > > Some drivers seem to use macros such as _IOR/_IOW in a way that
ends
> up
> > > > calling the sizeof() operator twice. For eg:
> > > >
> > > > -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> > > > +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
> 
> But this changes the define. You want
> 
> #define FBIO_ATY128_GET_MIRROR	_IOR_BAD('@', 1, __u32*)

	Maybe I got something wrong, but could someone please help me to
understand why introduce _IOR_BAD here? Thanks first! :)

	IMO, the birth of new ioctl definition convention considers
"size" of argument as a part, so we should conform to this rule.
_IOR_BAD is no different as old one <_IOR('@', 1, sizeof(__u32*))>,
which expands as sizeof(sizeof(__32*)) and actually assume temp result
of internal sizeof as the argument. Of course this didn't reflect the
true point and we should change the definition. :)

	Also I'm confused about the modification about using size_t to
replace sizeof(). Take MATROXFB_SET_OUTPUT_MODE for example:

(old)	#define MATROXFB_SET_OUTPUT_MODE
_IOW('n',0xFA,sizeof(struct matroxioc_output_mode))
(now)	#define MATROXFB_SET_OUTPUT_MODE        _IOW('n',0xFA,size_t)

	The size of matroxioc_output_mode is 8 bytes on all platforms,
however size_t will be calculated as 4 bytes on 32bit arch and 8 bytes
on 64bit arch. So this is also like using sizeof(), which imposes the
difference between 32bit ioctl number and 64bit ioctl number. However in
standard manner, I mean:
	#define MATROXFB_SET_OUTPUT_MODE        _IOW('n',0xFA,struct
matroxioc_output_mode)
 	The value should be identical on all platforms, which save our
efforts to do useless conversion when running 32bit apps on 64bit
platform.

	The most important is: to use sizeof() or size_t here both
messed the ioctl definition, which violate the initial motivation of
_IO**, is it?

> Something else we should do is to change all occurrences of 'size'
> here into 'argtype'. All this nonsense came because of the bad choice
> of identifier.
	Agree. The inaccurate name here confused us... :)
