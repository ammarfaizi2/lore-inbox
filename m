Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTFDX3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTFDX3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:29:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30224 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264300AbTFDX3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:29:21 -0400
Date: Thu, 5 Jun 2003 00:42:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
Message-ID: <20030605004246.H22460@flint.arm.linux.org.uk>
Mail-Followup-To: "P. Benie" <pjb1008@eng.cam.ac.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306041050250.14593-100000@home.transmeta.com> <Pine.HPX.4.33L.0306041937290.18475-100000@punch.eng.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.HPX.4.33L.0306041937290.18475-100000@punch.eng.cam.ac.uk>; from pjb1008@eng.cam.ac.uk on Wed, Jun 04, 2003 at 08:46:51PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 08:46:51PM +0100, P. Benie wrote:
> The problem isn't to do with large writes. It's to do with any sequence of
> writes that fills up the receive buffer, which is only 4K for N_TTY. If
> the receiving program is suspended, the buffer will fill sooner or later.

If the tty drivers buffer fills, we don't sleep in tty->driver->write,
but we return zero instead.  If we are in non-blocking mode, and we
haven't written any characters, we return -EAGAIN.  If we have, we
return the number of characters which the tty driver accepted.

However, the problem you are referring to is what happens if you have
a blocking process blocked in write_chan() in n_tty.c, and we have
a non-blocking process trying to write to the same tty.

Reading POSIX, it doesn't seem to be clear about our area of interest,
and I'd even say that it seems to be unspecified.

What are the pipe semantics in this case?  According to my reading of
POSIX write(), if you have a blocked non-blocking writer, a non-blocking
writer should receive EAGAIN.  It would seem sensible to apply the
same rules to terminal devices as well as pipes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

