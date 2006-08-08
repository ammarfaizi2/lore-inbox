Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWHHTeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWHHTeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWHHTeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:34:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030241AbWHHTeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:04 -0400
Date: Tue, 8 Aug 2006 15:36:34 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060808193634.GN16231@redhat.com>
References: <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com> <20060804210826.GE16231@redhat.com> <m164h8p50c.fsf@ebiederm.dsl.xmission.com> <20060804234327.GF16231@redhat.com> <m1hd0rmaje.fsf@ebiederm.dsl.xmission.com> <20060807174439.GJ16231@redhat.com> <m17j1kctb8.fsf@ebiederm.dsl.xmission.com> <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 11:01:53PM -0600, Eric W. Biederman wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> >> >> >
> >> >> >> 
> >> >> >> The error is the uncompressed length does not math the stored length
> >> >> >> of the data before from before we compressed it.  Now what is
> >> >> >> fascinating is that our crc's match (as that check is performed first).
> >> >> >> 
> >> >> >> Something is very slightly off and I don't see what it is.
> >> >> >
> >> >> > I printed out orig_len -> 5910532 (which matches vmlinux.bin)
> >> >> >              bytes_out -> 5910531
> >> >> >
> >> >> >> 
> >> > It seems to be an AMD64 vs EM64T problem.  AMD chipsets work but Intel
> >> > chipsets don't.  
> >> >
> >> > I also blindly incremented bytes_out (as a really cheap hack), it didn't
> >> > work until I added some random putstr's below it (timing??).  Then the
> >> > kernel booted. 
> >> >
> >> > Still looking into things.  
> >> 
> >> Odd.  I wonder if I'm missing a serializing instruction somewhere,
> >> to ensure the effects of ``self modifying code'' aren't a problem.
> >> As I read Intels Documentation if you have a jump before you get
> >> to the code there shouldn't be a problem.
> >> 
> >> Still that doesn't really explain bytes_out.
> >> 
> >
> > So I narrowed down the problem but it isn't obvious to me why this problem
> > exists.  Basically, even though bytes_out is supposed to be initialized to
> > 0, it becomes -1 before entering decompress_kernel().  Of course, the
> > fallout is in flush_window() bytes_out wounds up being one less than
> > outcnt and hence my original problem.
> >
> > Any thoughts on how to debug where this could be getting corrupted?  
> 
> Looking at my build it appears bytes_out is being placed in the .bss.
> A little odd since it is zero initialized but no big deal.
> Could you confirm that bytes_out is being placed in the .bss section 
> by inspecting arch/x86_64/boot/compresssed/misc.o and
> arch/x86_64/boot_compressed/vmlinux.   "readelf -a $file" and then
> looking up the section number and looking at the section table to see
> which section it is was my technique.

Yes bytes_out is in the .bss for both files.  

> 
> If bytes_out is in the .bss for you then I suspect something is not
> correctly zeroing the .bss.  Or else the .bss is being stomped.
> 
> I'm not certain how rep stosb can be done wrong but some bad pointer
> math could have done it.

Even worse, from the time the .bss is cleared to the time gunzip() is
called inside decompress_kernel(), there is very little code to do some
stomping.  

So I am stuck trying to debug this.  This code seems very fragile.  The
more debug code I add (ie putstr) the more the length is off (varies from
-32 to +1).  Makes me scratch my head as to what is really going on here.  

I created a really pathetic patch to get the thing to boot but even that
doesn't make sense.  


diff --git a/arch/x86_64/boot/compressed/misc.c b/arch/x86_64/boot/compressed/misc.c
index 0e6c4b7..614416e 100644
--- a/arch/x86_64/boot/compressed/misc.c
+++ b/arch/x86_64/boot/compressed/misc.c
@@ -183,6 +183,7 @@ #define OLD_CL_MAGIC 0xA33F
 extern unsigned char input_data[];
 extern int input_len;
 
+static long dummy;
 static long bytes_out = 0;
 
 static void *malloc(int size);
@@ -594,6 +595,7 @@ asmlinkage void decompress_kernel(void *
 	if ((ulg)output >= 0xffffffffffUL)
 		error("Destination address too large");
 
+	bytes_out = 0;
 	makecrc();
 	putstr(".\nDecompressing Linux...");
 	gunzip();

And yes, the 'dummy' variable needs to be there.  
I am trying to use gdb on vmlinux to fish for clues.  But I am at a loss
right now.  

Cheers,
Don

> 
> Eric
