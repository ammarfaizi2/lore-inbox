Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTAPSdR>; Thu, 16 Jan 2003 13:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTAPSdR>; Thu, 16 Jan 2003 13:33:17 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:33552 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267189AbTAPSdQ>; Thu, 16 Jan 2003 13:33:16 -0500
Message-ID: <3E26F6DC.D9150735@linux-m68k.org>
Date: Thu, 16 Jan 2003 19:15:56 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030115063349.A1521@almesberger.net> <20030116013125.ACE0F2C0A3@lists.samba.org> <20030115234258.E1521@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Werner Almesberger wrote:

> If there's a really nasty case, where you absolutely can't
> afford to sleep, you need to change the service to split
> "deregister" into:
> 
>  - prepare_deregister (like "deregister", but reversible)
>  - commit_deregister
>  - undo_deregister

You can simplify this. All you need are the following simple functions:

- void register();
- void unregister();
- int is_registered();
- void inc_usecount();
- void dec_usecount();
- int get_usecount();

It's important to understand that the registered state and the usecount
are completely independent. As soon as the object is unregistered and
the usecount is zero, the object can be freed, but it doesn't matter in
which order it happens.
The problem is now that we are very limited how we can use these
functions. We can only unregister an object after the usecount became
zero, although it's also possible to first unregister the object and
then wait for the usecount. Only when we can do the latter is it
possible to safely force the removal of the object.

bye, Roman

