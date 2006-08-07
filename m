Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWHGSKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWHGSKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWHGSKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:10:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63128 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932261AbWHGSKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:10:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060804210826.GE16231@redhat.com>
	<m164h8p50c.fsf@ebiederm.dsl.xmission.com>
	<20060804234327.GF16231@redhat.com>
	<m1hd0rmaje.fsf@ebiederm.dsl.xmission.com>
	<20060807174439.GJ16231@redhat.com>
Date: Mon, 07 Aug 2006 12:08:27 -0600
In-Reply-To: <20060807174439.GJ16231@redhat.com> (Don Zickus's message of
	"Mon, 7 Aug 2006 13:44:39 -0400")
Message-ID: <m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

> On Sat, Aug 05, 2006 at 10:07:01AM -0600, Eric W. Biederman wrote:
>> Don Zickus <dzickus@redhat.com> writes:
>> 
>> >> The length error comes from lib/inflate.c 
>> >> 
>> >> I think it would be interesting to look at orig_len and bytes_out.
>> >> 
>> >> My hunch is that I have tripped over a tool chain bug or a weird
>> >> alignment issue.
>> >
>> > I thought so too, but I took vmlinuz images from people (Vivek) who had it
>> > boot on their systems but those images still failed on my two machines.  
>> >
>> >> 
>> >> The error is the uncompressed length does not math the stored length
>> >> of the data before from before we compressed it.  Now what is
>> >> fascinating is that our crc's match (as that check is performed first).
>> >> 
>> >> Something is very slightly off and I don't see what it is.
>> >
>> > I printed out orig_len -> 5910532 (which matches vmlinux.bin)
>> >              bytes_out -> 5910531
>> >
>> >> 
>> >> After looking at the state variables I would probably start looking
>> >> at the uncompressed data to see if it really was decompressing
>> >> properly.  If nothing else that is the kind of process that would tend
>> >> to spark a clue.
>> >
>> > I am not familiar with the code, so very few sparks are flying.  I'll
>> > still dig through though.  Thanks for the tips.
>> 
>> I guess the interesting thing to do would be to 
>> - Recompute the crc to see if we still match.
>> - Possibly instrument of flush_window.
>> 
>> I have a strange feeling that the uncompressed data is getting corrupted
>> after we have flushed the window.
>
> It seems to be an AMD64 vs EM64T problem.  AMD chipsets work but Intel
> chipsets don't.  
>
> I also blindly incremented bytes_out (as a really cheap hack), it didn't
> work until I added some random putstr's below it (timing??).  Then the
> kernel booted. 
>
> Still looking into things.  

Odd.  I wonder if I'm missing a serializing instruction somewhere,
to ensure the effects of ``self modifying code'' aren't a problem.
As I read Intels Documentation if you have a jump before you get
to the code there shouldn't be a problem.

Still that doesn't really explain bytes_out.


Eric
