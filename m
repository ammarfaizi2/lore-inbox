Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270653AbTGNSRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270662AbTGNSRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:17:10 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:47063 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S270653AbTGNSRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:17:08 -0400
Importance: Normal
Sensitivity: 
Subject: Re: sizeof (siginfo_t) problem
To: jakub@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF8354A4F2.09CC83D0-ONC1256D63.0064A671@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 14 Jul 2003 20:31:34 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 14/07/2003 20:31:39
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:

>I have noticed this on s390x in a different place:
>MD_FALLBACK_FRAME_STATE_FOR in gcc, in order to unwind through
>signal frames, needs to locate ucontext, and looking at
>stack pointer + 8 + sizeof(siginfo_t) (which works on s390 32-bit)
>did not work at all, everything was shifted by 8 bytes.

The MD_FALLBACK_FRAME_STATE_FOR macro does not use sizeof(siginfo_t)
at all, but hardcodes 128.  (This has always been the case, and was
done to avoid the need to include signal.h.)  This is still broken
with the current kernel behaviour, though.

It is strange that I didn't notice the problem earlier; apparently
most of the places where unwinding through signal frames is required
use non-RT frames ...

>This though means that the kernel siginfo_t change cannot be done
>just in asm-*/siginfo.h headers - at least places where siginfo_t
>is present within some structures ever visible to userland a dummy
>8 byte pad needs to be inserted.

As userspace expects a size of 128 bytes, and with the change
the size now *is* 128 bytes, why would a pad be required?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

