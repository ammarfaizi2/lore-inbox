Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRAJTlt>; Wed, 10 Jan 2001 14:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRAJTlj>; Wed, 10 Jan 2001 14:41:39 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:20239 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S131958AbRAJTlV>; Wed, 10 Jan 2001 14:41:21 -0500
Message-ID: <3A5CBAE3.ACDD2494@intel.com>
Date: Wed, 10 Jan 2001 11:41:23 -0800
From: rdunlap <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] Re: That horrible hack from hell called A20
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F06E2EC5F@orsmsx31.jf.intel.com>
Content-Type: multipart/mixed;
 boundary="------------3EACD08132E719D8EFDDC534"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3EACD08132E719D8EFDDC534
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Linus Torvalds wrote:
> 
> On Tue, 5 Dec 2000, Linus Torvalds wrote:
> >
> > Right now this is my interim patch (to clean test11). The thing to
> note is
> > that I decreased the keyboard controller timeout by a factor of about
> 167,
> > while making the "delay" a bit longer.
> 
> Oh, btw, I forgot to ask people to give this a whirl. I assume it fixes
> the APM problems for Kai.
> 
> It definitely won't fix the silly Olivetti M4 issue (we still touch bit
> #2
> in 0x92). We'll need to fix that by testing A20 before bothering with
> the
> 0x92 stuff. Alan, that should get fixed in 2.2.x too - clearly those
> Olivetti machines can be considered buggy, but even so..
> 
> Who else had trouble with the keyboard controller?

Alan-

Here's a patch to 2.2.19-pre7 that is essentially a backport of the
2.4.0 gate-A20 code.

This speeds up booting on my fast-A20 board (Celeron 500 MHz, no KBC)
from 2 min:15 seconds to <too small to measure by my wrist watch>.

Kai, you reported that your system was OK with 2.4.0-test12-pre6.
Does that mean that it's OK with 2.4.0-final also?

Comments?  Should we be merging Peter's int 0x15-first patch with this?
And test for A20-gated after each step, before going to the next
method?  Get that working and then backport it to 2.2.19?
Have their been any test reports on Peter's last patch?  I didn't see
any, but if that should be the goal, I'll give it a whirl.

I'd like to see this applied to 2.2.19.  At least changing the long
delay so that it doesn't appear that Linux isn't going to boot...

Thanks,
~Randy
--------------3EACD08132E719D8EFDDC534
Content-Type: text/plain; charset=us-ascii;
 name="p7-a20-backport.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p7-a20-backport.patch"

--- linux/arch/i386/boot/setup.S.org	Tue Jan  9 15:59:08 2001
+++ linux/arch/i386/boot/setup.S	Tue Jan  9 16:42:40 2001
@@ -578,46 +578,44 @@
 	lgdt	gdt_48		! load gdt with whatever appropriate
 
 ! that was painless, now we enable A20
-
-! if this is SC410 or a few other bits we need to do it with the 'fast' method
-
-        in      al,#0x92        ! read "System Control Port A"
-        or      al,#0x02        ! Set "Alternate Gate A20" - Bit
-        out     #0x92,al        ! write "System Control Port A"
+	call	empty_8042
 
 ! do it the normal way too, so as not to upset normal machines
-
-	call	empty_8042
 	mov	al,#0xD1		! command write
 	out	#0x64,al
 	call	empty_8042
+
 	mov	al,#0xDF		! A20 on
 	out	#0x60,al
 	call	empty_8042
 
+! if this is SC410 or a few other bits we need to do it with the 'fast' method
+!
+!	You must preserve the other bits here. Otherwise embarrasing things
+!	like laptops powering off on boot happen. Corrected version by Kira
+!	Brown from Linux 2.2
+
+        in      al,#0x92        ! read "System Control Port A"
+        or      al,#0x02        ! Set "Alternate Gate A20" - Bit
+        out     #0x92,al        ! write "System Control Port A"
+
 ! wait until a20 really *is* enabled; it can take a fair amount of
 ! time on certain systems; Toshiba Tecras are known to have this
-! problem.  The memory location used here is the int 0x1f vector,
-! which should be safe to use; any *unused* memory location < 0xfff0
-! should work here.  
-
-#define	TEST_ADDR 0x7c
+! problem.  The memory location used here (0x200) is the int 0x80
+! vector, which should be safe to use.
 
-	push	ds
 	xor	ax,ax			! segment 0x0000
-	mov	ds,ax
+	mov	fs,ax
 	dec	ax			! segment 0xffff (HMA)
 	mov	gs,ax
-	mov	bx,[TEST_ADDR]		! we want to restore the value later
 a20_wait:
-	inc	ax
-	mov	[TEST_ADDR],ax
+	inc	ax			! unused memory location <0xfff0
+	seg	fs
+	mov	[0x200],ax		! we use the "int 0x80" vector
 	seg	gs
-	cmp	ax,[TEST_ADDR+0x10]
+	cmp	ax,[0x210]		! and its corresponding HMA addr
 	je	a20_wait		! loop until no longer aliased
-	mov	[TEST_ADDR],bx		! restore original value
-	pop	ds
-		
+
 ! make sure any possible coprocessor is properly reset..
 
 	xor	ax,ax
@@ -797,10 +795,17 @@
 !
 ! Some machines have delusions that the keyboard buffer is always full
 ! with no keyboard attached...
+!
+! If there is no keyboard controller, we will usually get 0xff
+! to all the reads.  With each IO taking a microsecond and
+! a timeout of 100,000 iterations, this can take about half a
+! second ("delay" == outb to port 0x80). That should be ok,
+! and should also be plenty of time for a real keyboard controller
+! to empty.
 
 empty_8042:
        push    ecx
-       mov     ecx,#0xFFFFFF
+       mov     ecx,#100000
 
 empty_8042_loop:
        dec     ecx
@@ -840,7 +845,7 @@
 ! Delay is needed after doing I/O
 !
 delay:
-	.word	0x00eb			! jmp $+2
+	out	#0x80,al
 	ret
 
 !


--------------3EACD08132E719D8EFDDC534--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
