Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278908AbRJVUvu>; Mon, 22 Oct 2001 16:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278725AbRJVUvl>; Mon, 22 Oct 2001 16:51:41 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:414 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278915AbRJVUv0>; Mon, 22 Oct 2001 16:51:26 -0400
Date: Mon, 22 Oct 2001 16:51:57 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Hawkes <hawkes@oss.sgi.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
Message-ID: <20011022165157.M23213@redhat.com>
In-Reply-To: <20011022161527.K23213@redhat.com> <E15vlx2-0003HO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15vlx2-0003HO-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 22, 2001 at 09:45:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 09:45:36PM +0100, Alan Cox wrote:
> > On Mon, Oct 22, 2001 at 01:05:10PM -0700, John Hawkes wrote:
> > > This patch eliminates gcc 3.0.1 warnings, "multi-line string literals are
> > > deprecated", in two include/asm-i386 files.  Patches cleanly for at least
> > > 2.4.10 and 2.4.12, and tested in 2.4.10.
> > 
> > Please reject this patch.  The gcc folks are wrong in this case.
> 
> Im curious - why do you make that specific claim. The multiline literals are
> rather ugly.

Which of the following is more readable:

/* try atomic lock inline, if that fails, spin out of line */
	"\tbtsl $1,%0\n"
	"\tbne 2f\n"
	"1:\n"
	"\t.section .text.lock\n\n"
	"\t2:\tcmpl $0,%0\n"
	"\tbne 2b\n"
	"\trep ; nop\n"
	"\tjmpl 1b\n\n"
	"\t.section .previous\n"

or:

/* try atomic lock inline, if that fails, spin out of line */
"	btsl $1,%0
1:
	.section .text.lock

2:	cmpl $0,%0
	bne 2b
	jmpl 1b

	.section .previous"

or:
	while (unlikely(test_and_set_bit(1, lock))) {
		while (lock.value)
			arch_pause();
	}

Ooops, sorry, ignore 3 -- that's only possible in a world where there is 
intrinsic support in the compiler to generate the assembly we're aiming 
for.  But of the two assembly versions, I think the second is much more 
readable.  The few gcc people I've spoken to locally about this agreed with 
me when I showed them some of the inline assembly bits in the two forms as 
above.

		-ben
