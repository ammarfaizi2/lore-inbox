Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290769AbSAaAVp>; Wed, 30 Jan 2002 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290773AbSAaAVg>; Wed, 30 Jan 2002 19:21:36 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49165 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S290769AbSAaAVb>; Wed, 30 Jan 2002 19:21:31 -0500
Date: Thu, 31 Jan 2002 01:21:33 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 OOPS in tty code.
Message-ID: <20020131012133.C7944@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020121151037.A21622@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121151037.A21622@ucw.cz>; from bulb@ucw.cz on Mon, Jan 21, 2002 at 03:10:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello All,
> 
> Tty device code causes oopses when closing /dev/console and devfs is used.
> The bug is reproducible on 2.4.17 UML port. The uml arch code however does
> not seem involved. The problem is, that the tty flip buffer flushing task
> somehow remains in the tq_timer task queue when the tty struct is freed.
> When the device is subsequently reopened (or the memory allocated for other
> purpose), run_task_queue OOPSes when it comes acros the entry, that has
> it's pointers overwriten.

Well, I hunted down the bug a bit more. The user-mode code DOES get involved.
When /dev/console is open, the pointer is written to vts[line].tty (in
console_open), but noone cares to remove it when it's freed. And I don't
have any process running on line 0. Just I am not sure, weather the correct
way is to avoid freeing the structure (eg. via ref-count) or to remove the
pointer in close_console.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
