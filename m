Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbSKSQ6f>; Tue, 19 Nov 2002 11:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKSQ6f>; Tue, 19 Nov 2002 11:58:35 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:15314 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266999AbSKSQ6T>; Tue, 19 Nov 2002 11:58:19 -0500
Message-ID: <3DDA74D2.6080802@kegel.com>
Date: Tue, 19 Nov 2002 09:28:50 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Grant Taylor <gtaylor+lkml_ihdeh111902@picante.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Taylor wrote:
> Meanwhile, in the more important caveat department (Dan, this will
> appeal to you), I found a while back that signals cause pain with
> epoll.
> 
> For example, sometimes TCP reads return EAGAIN when in fact they have
> data.  This seems to stem from the case where the signal is found
> before the first segment copy (from tcp.c circa 1425, there's even a
> handy FIXME note there).  If you use epoll and get an EAGAIN, you have
> no idea if it was a signal or a real empty socket unless you are also
> very careful to notice when you got a signal during the read.
 > ...
> 		/* We need to check signals first, to get correct SIGURG
> 		 * handling. FIXME: Need to check this doesnt impact 1003.1g
> 		 * and move it down to the bottom of the loop
> 		 */
> 		if (signal_pending(current)) {
> 			if (copied)
> 				break;
> 			copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
> 			break;
> 		}

eek!  Thanks for noticing that!

Jamie wrote:

> Mark's right, it should be EINTR.  EAGAIN shouldn't break any
> single-thread user state machines using poll/select, as a non-blocking
> read is always allowed to return EAGAIN for any transient reason.
> 
> I'm not sure if EAGAIN can cause a poll() wakeup event to be missed.
> If so, that would be a TCP bug that breaks epoll, and it would also
> break some user state machines using poll/select, when there are
> multiple processes waiting on a socket.

I guess we should scour the sources looking for ways read() and write()
can return EAGAIN, and make sure that there is no chance this causes
a hang in user state machines that rely on epoll.  (Sure would be nice
if the Stanford Checker was up to this kind of thing.)
- Dan



