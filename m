Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSGHXa4>; Mon, 8 Jul 2002 19:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSGHXaz>; Mon, 8 Jul 2002 19:30:55 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:5650 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317261AbSGHXay>;
	Mon, 8 Jul 2002 19:30:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates 
In-reply-to: Your message of "Mon, 08 Jul 2002 11:41:52 MST."
             <Pine.LNX.4.33.0207051554580.961-100000@geena.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 09:33:24 +1000
Message-ID: <21467.1026171204@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 11:41:52 -0700 (PDT), 
Patrick Mochel <mochel@osdl.org> wrote:
>- Add struct module * owner field to struct device_driver
>- Change {get,put}_driver to use it

struct device_driver * get_driver(struct device_driver * drv)
{
        if (drv && drv->owner)
                if (!try_inc_mod_count(drv->owner))
                        return NULL;
        return drv;
}

is racy.  The module can be unloaded after if (drv->owner) and before
try_inc_mod_count.  To prevent that race, drv itself must be locked
around calls to get_driver().

The "normal" method is to have a high level lock that controls the drv
list and to take that lock in the register and unregister routines and
around the call to try_inc_mod_count.  drv->bus->lock is no good,
anything that relies on reading drv without a lock or module reference
count is racy.  I suggest you add a global driverfs_lock.

