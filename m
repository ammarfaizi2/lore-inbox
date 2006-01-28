Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWA1UHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWA1UHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 15:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWA1UHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 15:07:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63884 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750721AbWA1UHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 15:07:08 -0500
Date: Sat, 28 Jan 2006 12:06:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: mingo@elte.hu, steiner@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, akpm@osdl.org
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-Id: <20060128120620.00be8227.pj@sgi.com>
In-Reply-To: <20060128192736.GD18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com>
	<20060127191400.aacb8539.pj@sgi.com>
	<20060128133244.GA22704@elte.hu>
	<20060128192736.GD18730@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> Task finishes work and does sched_setaffinity(saved_mask).

Stupid task.  If task wants to run on -all- cpus on a
hotplug system, task should not pass a saved mask, but
rather construct a mask with all bits set and pass that:

  cpu_set_t mask;
  unsigned int i;

  /* set all bits in mask - code totally untested */
  for (i = 0; i < sizeof(cpu_set_t) / sizeof (__cpu_mask); i++)
    mask.__bits[i] = ~0;

  sched_setaffinity(&mask);

Similar problems exist for a task running in a cpuset under
migration.  Saved masks are useless in all but static systems,
having no migration, no hotplug.

That, or use a library on top of this that lets the task work
with relative (to whatever is available) CPU and (for the
mbind/mempolicy calls) Memory Node numbers and that handles
the above details.  If all goes well, I should be releasing
such a library in the not distant future.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
