Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIK1L>; Tue, 9 Jan 2001 05:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRAIK1D>; Tue, 9 Jan 2001 05:27:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131313AbRAIK0w>;
	Tue, 9 Jan 2001 05:26:52 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101091002.f09A2El13844@flint.arm.linux.org.uk>
Subject: Re: [PATCH] advansys.c: include missing restore_flags, etc
To: acme@conectiva.com.br (Arnaldo Carvalho de Melo)
Date: Tue, 9 Jan 2001 10:02:14 +0000 (GMT)
Cc: linux@advansys.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010109001443.A20786@conectiva.com.br> from "Arnaldo Carvalho de Melo" at Jan 09, 2001 12:14:43 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo writes:
> 	Please consider applying, comments in the patch.

Can't the following be fixed properly?

> -STATIC int
> +STATIC unsigned long
>  DvcEnterCritical(void)
>  {
> -    int    flags;
> +    unsigned long flags;
>  
>      save_flags(flags);
>      cli();

Guess what happens here?

    return flags;

> @@ -9965,7 +9972,7 @@
>  }
>  
>  STATIC void
> -DvcLeaveCritical(int flags)
> +DvcLeaveCritical(unsigned long flags)
>  {
>      restore_flags(flags);
>  }

The above doesn't work on some architectures.  Its better to use a macro
if you want to separate this out.  ie, something like (davem will have to
okay it tho):

#define DvcEnterCritical()				\
 ({ unsigned long __flags; save_flags(__flags); cli(); __flags; })

#define DvcLeaveCritical(flags)				\
 do { restore_flags(flags); } while (0)

This should then ensure that you don't end up with problems associated
with register windows on the sparc or whatever.  Even better would be
to use a spinlock instead of Dvc?????Critical.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
