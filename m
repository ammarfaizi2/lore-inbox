Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272149AbTG2Vie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272137AbTG2Vht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:37:49 -0400
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:8464 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP id S272133AbTG2VfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:35:00 -0400
Date: Tue, 29 Jul 2003 22:34:58 +0100
From: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030729213458.GA21517@bodmin.doc.ic.ac.uk>
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk> <20030729203745.GA2221@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729203745.GA2221@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-07-29 22:37:45 +0000, Andries Brouwer wrote:
> On Tue, Jul 29, 2003 at 09:38:52PM +0100, John Bradford wrote:
> 
> > Ah, I just thought, for debugging purposes we could have LEDs for:
> > 
> > * BKL taken
> > * Servicing interrupt
> > * Kernel stack usage > 2K
> 
> Ever tried keyboard.c:register_leds() ?

Nope -- I have just hacked together a driver to expose the keyboard leds
vie my leds interface (see below), _but_ register_leds is not an exported
symbol, not is it declared in <linux/keyboard.h> (on 2.4.21 anyway), so
you'll need to make some modifications if you want to actually use it.

Also, I'm not sure if there is a way of unregistering leds you register
in this way -- I've done a bodge job thus far, but you take your life in
your hands when you unload this module (in other words, don't). 

Regards,

Philip Willoughby

Systems Programmer, Department of Computing, Imperial College, London, UK
-- 
echo bzidd@nfo.ho.co.se | tr "bizndfohces" "pwgd9ociaku"
Why reinvent the wheel?                 Because we can make it rounder...

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/leds.h>
#include <linux/sched.h>
#include <linux/keyboard.h>
#include <linux/spinlock.h>
#include <asm/current.h>

static unsigned int keybleds;
static spinlock_t keybleds_lock = SPIN_LOCK_UNLOCKED;

static void
release (void * ignored)
{
  MOD_DEC_USE_COUNT;
}

static void
reserve (void * ignored)
{
  MOD_INC_USE_COUNT;
}

static void
set_state (unsigned int idx, unsigned char state, void *ignored)
{
  spin_lock(&keybleds_lock);
  keybleds &= ~(1 << idx);
  keybleds |= state & (1<<idx);
  spin_unlock(&keybleds_lock);
}

static unsigned char
get_state (unsigned int idx, void * ignored)
{
  unsigned char rv;
  spin_lock(&keybleds_lock);
  rv = (unsigned char)(keybleds & (1 << idx));
  spin_unlock(&keybleds_lock);
  return rv;
}

static struct linux_leds_info kbleds = {
get_state:get_state,
set_state:set_state,
reserve:reserve,
release:release,
count:3,
data:NULL,
drivername:THIS_MODULE,
};

static int __init
init_keyb_leds (void)
{
  register_leds(0, 0, &keybleds, 1);
  register_leds(0, 1, &keybleds, 2);
  register_leds(0, 2, &keybleds, 4);
  return leds_add (&kbleds);
}

static void __exit
cleanup_keyb_leds (void)
{
  register_leds(0, 3, NULL, 0);
  register_leds(0, 1, NULL, 0);
  register_leds(0, 2, NULL, 0);
  register_leds(0, 2, NULL, 0);
}

module_init(init_keyb_leds);
module_exit(cleanup_keyb_leds);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Philip Graham Willoughby <pgw@alumni.doc.ic.ac.uk>");
MODULE_DESCRIPTION("This module exposes the keyboard LEDs through the generic LEDs interface");
MODULE_SUPPORTED_DEVICE("Keyboards");
EXPORT_NO_SYMBOLS;

