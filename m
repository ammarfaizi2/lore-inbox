Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316518AbSEOXyr>; Wed, 15 May 2002 19:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316521AbSEOXyr>; Wed, 15 May 2002 19:54:47 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:8661 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S316518AbSEOXyq>; Wed, 15 May 2002 19:54:46 -0400
Message-Id: <200205152353.g4FNrew30146@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Pavel Machek <pavel@suse.cz>, "Vamsi Krishna S ." <vamsi@in.ibm.com>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Wed, 15 May 2002 16:53:18 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Gross, Mark" <mark.gross@intel.com>, "'Erich Focht'" <efocht@ess.nec.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        "'Bharata B Rao'" <bharata@in.ibm.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com> <20020515120722.A17644@in.ibm.com> <20020515140448.C37@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 May 2002 10:04 am, Pavel Machek wrote:
> Okay, what about:
>
> Thread 1 is in kernel and holds lock A. You need lock A to dump state.
> When you move 1 to phantom runqueue, you loose ability to get A and
> deadlock.
>
> What prevents that?

Any pending tasklet / bottom half + top half get processes by the real CPU's 
even thought the I/O bound process may have been moved to the phantom run 
queue.  Its just that for the suspended processes sitting on the phantom 
queue this processing stops with the call to try_to_wake_up, until the 
process is moved back onto a run queue with a CPU.

The only way I can see what your talking about happening is for some kernel 
code (or driver) to grab a lock and then hold it across a call to one of the 
sleep_on functions pending some I/O.

Any driver that holds a lock across any sleep_on call I think is abusing 
locks and needs adjusting.

Nothing prevents someone writing a driver that abuses locks.

If you know of such a case I need to worry about or there is another way for 
this design to get into trouble please let me know.  I'll look into it as 
quickly as I can.

--mgross
