Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSGWVHZ>; Tue, 23 Jul 2002 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSGWVHZ>; Tue, 23 Jul 2002 17:07:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38784 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318209AbSGWVHY>;
	Tue, 23 Jul 2002 17:07:24 -0400
Date: Tue, 23 Jul 2002 14:08:52 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Dave Jones <davej@suse.de>
cc: Markus Pfeiffer <profmakx@profmakx.org>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU detection broken in 2.5.27?
In-Reply-To: <20020723225628.D16446@suse.de>
Message-ID: <Pine.LNX.4.44.0207231401070.954-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Dave Jones wrote:

> On Tue, Jul 23, 2002 at 01:34:37PM -0700, Patrick Mochel wrote:
>  > 
>  > > Which stepping do you have ?
>  > 2.
> 
> I meant ->x86_model there, I assume you did too, and you have a 0xF24/0xF27 cpu.
> I wasn't aware these were HT aware. In fact, only 0xF50 are confirmed.
> Interesting.

Actually, it's Family 15, Model 1, Stepping 2. Though the HT capability
shows up, it's disabled, so it's one of the pre-Foster P4s (though I don't
know what they're called).

>  > Sorry, it was in the invisible charset. 
> 
> Ah ok. I'll install the correct font later.

You should already have it, though you might have to look a bit harder. 

>  > ===== arch/i386/kernel/cpu/intel.c 1.3 vs edited =====
>  > --- 1.3/arch/i386/kernel/cpu/intel.c	Wed Jul 10 03:46:31 2002
>  > +++ edited/arch/i386/kernel/cpu/intel.c	Tue Jul 23 13:25:01 2002
>  > @@ -232,15 +232,19 @@
>  >  	if (c->x86 == 6) {
>  >  		switch (c->x86_model) {
>  >  		case 5:
>  > -			if (l2 == 0)
>  > -				p = "Celeron (Covington)";
>  > -			if (l2 == 256)
>  > -				p = "Mobile Pentium II (Dixon)";
>  > +			if (c->x86_mask == 0) {
>  > +				if (l2 == 0)
>  > +					p = "Celeron (Covington)";
>  > +				else if (l2 == 256)
>  > +					p = "Mobile Pentium II (Dixon)";
> 
> Something that just nagged me about this code.
> Where are those strings stored ? If they're in the same
> text as this code, we shouldn't be creating references to them,
> as after boot, all this will go poof. (it's __init)

They're being placed in .rodata, so they should be ok. 

New patch, with the name for my P4 reset..

	-pat

===== arch/i386/kernel/cpu/intel.c 1.3 vs edited =====
--- 1.3/arch/i386/kernel/cpu/intel.c	Wed Jul 10 03:46:31 2002
+++ edited/arch/i386/kernel/cpu/intel.c	Tue Jul 23 14:07:12 2002
@@ -232,15 +232,19 @@
 	if (c->x86 == 6) {
 		switch (c->x86_model) {
 		case 5:
-			if (l2 == 0)
-				p = "Celeron (Covington)";
-			if (l2 == 256)
-				p = "Mobile Pentium II (Dixon)";
+			if (c->x86_mask == 0) {
+				if (l2 == 0)
+					p = "Celeron (Covington)";
+				else if (l2 == 256)
+					p = "Mobile Pentium II (Dixon)";
+			}
 			break;
 			
 		case 6:
 			if (l2 == 128)
 				p = "Celeron (Mendocino)";
+			else if (c->x86_mask == 0 || c->x86_mask == 5)
+				p = "Celeron-A";
 			break;
 			
 		case 8:
@@ -348,6 +352,26 @@
 			  [4] "Pentium MMX",
 			  [7] "Mobile Pentium 75 - 200", 
 			  [8] "Mobile Pentium MMX"
+		  }
+		},
+		{ X86_VENDOR_INTEL,     6,
+		  { 
+			  [0] "Pentium Pro A-step",
+			  [1] "Pentium Pro", 
+			  [3] "Pentium II (Klamath)", 
+			  [4] "Pentium II (Deschutes)", 
+			  [5] "Pentium II (Deschutes)", 
+			  [6] "Mobile Pentium II",
+			  [7] "Pentium III (Katmai)", 
+			  [8] "Pentium III (Coppermine)", 
+			  [10] "Pentium III (Cascades)",
+			  [11] "Pentium III (Tualatin)",
+		  }
+		},
+		{ X86_VENDOR_INTEL,     15,
+		  {
+			  [1] "Pentium 4 (Unknown)",
+			  [5] "Pentium 4 (Foster)",
 		  }
 		},
 	},

