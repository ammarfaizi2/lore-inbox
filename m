Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752935AbWKCBzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbWKCBzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbWKCBzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:55:05 -0500
Received: from mga03.intel.com ([143.182.124.21]:42808 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752932AbWKCBzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:55:02 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,382,1157353200"; 
   d="scan'208"; a="140332289:sNHT41038165"
Date: Thu, 2 Nov 2006 17:54:03 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-Id: <20061102175403.279df320.kristen.c.accardi@intel.com>
In-Reply-To: <20061101115618.GA1683@elf.ucw.cz>
References: <20061101115618.GA1683@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 12:56:18 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> (-mm1 behaves the same).
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
PCI Root Bridge whenever the lid opens up.

There is a bug here in that acpiphp shouldn't even be used on the X60 -
it has no hotpluggable slots.  This problem only occurs when acpiphp is
built in, as when a module it just doesn't load.  It appears to not clean
up after itself properly when it finds no ejectable slots and leaves the
acpi notifier installed for the PCI Root Bridge.  The message is printing
"cannot get bridge info" because it partially cleaned some stuff up (without
actually removing the notifier).  I'll put this bug into bugzilla since
I won't have time to fix right away:

http://bugzilla.kernel.org/show_bug.cgi?id=7452

Feel free to add yourself to the CC list if you are interested in being
notified when it is fixed.

Kristen
 
