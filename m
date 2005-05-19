Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVESOXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVESOXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVESOXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:23:33 -0400
Received: from general.keba.co.at ([193.154.24.243]:55164 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262513AbVESOX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:23:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01 whenRT program dumps core]
Date: Thu, 19 May 2005 16:23:16 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323213@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01 whenRT program dumps core]
Thread-Index: AcVcd99wgmBYx2RXQUCAYf5w7U0hfwABM/+A
From: "kus Kusche Klaus" <kus@keba.com>
To: "Steven Rostedt" <rostedt@goodmis.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "kus Kusche Klaus" <kus@keba.com>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the function coredump_wait there's a yield called:
> 
> static void coredump_wait(struct mm_struct *mm)
> {
> [...]
>         /* give other threads a chance to run: */
>         yield();
> 
>         zap_threads(mm);
> [...]
> 
> I don't see any reason for this.  Although the comment says 
> it's giving
> other threads a chance to run, but the zap_threads below it will just
> send a kill signal to all those sharing the mm and then this 
> thread will
> wait for completion (if there were threads to wait on).
> 
> Now if there were no other threads to wait on it would just continue.
> So, is there some real reason that this yield is there? Or is it just
> trying to be nice, as in saying, "I'm dieing now and just 
> don't want to
> waste others time" (which I highly doubt is the case).
> 
> The reason I'm asking this, is that RT tasks should not call yield,
> since it is pretty much meaningless, since an RT task won't 
> yield to any
> task of lesser priority, and in Ingo's current kernel the yield will
> send a bug message if it was called by an RT task.
> 
> Thanks,
> 
> -- Steve

Does that mean that the core dump is written 
with the rt prio of the task which dumps?

I'm not sure if this is a good idea: 
Dumping a big core might take *ages* (at least w.r.t. realtime),
especially because it usually goes to flash memory, a CF card,
or some other really slow device.

Doing that on a high rt prio is not nice; in an rt kernel, 
it may even keep interrupt handlers from responding...
Is there any way to do it in the background / at low prio?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
