Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRR7M>; Mon, 18 Dec 2000 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbQLRR7B>; Mon, 18 Dec 2000 12:59:01 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:38789 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130017AbQLRR6s>; Mon, 18 Dec 2000 12:58:48 -0500
Date: Mon, 18 Dec 2000 18:18:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu,
        torvalds@transmeta.com
Subject: Re: test13-pre3
In-Reply-To: <100841C16F12@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001218174625.26395B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Petr Vandrovec wrote:

> No. Without udelay() before first printk() it just does not boot on my
> motherboard. There were two choices: either remove all printk() from
> these loops (define Dprintk to null), or add udelay(x), where x >= 200,
> before first printk. I sent patch twice to linux-kernel, and to 
> mingo@redhat.com, and nobody said anything against it.

 I see.  But are you sure this is the right fix?  You may be covering
the real problem with this arbitrary delay.

 I haven't actually noticed any of your previous mails -- given the load
on the list I sometimes miss letters with "uninteresting" subjects. 

> No. If there is no udelay() before first printk(), on my GA-6VXD7 board
> (SMP VIA 694X) only 'Startup point 1.' is printed, but no 'Waiting
> for send to finish...'. So maybe we do not need udelay(200) below loop,
> but for sure we need udelay() before first printk(). (my board works
> without ANY udelay() in smpboot.c, except one I added... This one is 
> required.) If somebody lives in Prague, and wants to come with logical

 Other delays are imposed by the MPS (most if not all of them).  For
example there are systems that assert RESET to a CPU as a result of an
INIT IPI.  These systems need these delays to allow CPUs to recover. 

> analyzer (or if I should come with motherboard), I'm willing to continue
> testing. But current idea is that inb/outb done by cursor positioning
> code is incompatible with something else done in secondary CPU startup.

 Have you tried putting explicit display adapter (other ISA) I/O accesses
after sending the IPI to see if they trigger the problem?  IPIs are
transmitted over the inter-APIC bus and should be completely invisible to
other parts of the system.  But the code involved in processing a printk() 
may interact with the one executed by another CPU right after waking it
up.  It would be worth to investigate it...

> (it boots also without any kernel change with 'console=ttyS0,9600', but 
> it may be caused by slow serial line)

 Or by running different code.

> Without delay() both CPU die, and board does not react to anything except
> hard reset anymore (and sometime it does not react even to hard reset; lookup
> for my messages during last week).

 Now THAT is weird.  It might mean a chipset bug.  Still no idea how an
inter-APIC message might trigger it -- it completely bypasses MB
chipset...  Hmm, maybe not...  Is your I/O APIC discrete (like Intel's
82093AA) or integrated?  It appears there are vendors manufacturing I/O
APIC clones and this may imply new problems, sigh...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
