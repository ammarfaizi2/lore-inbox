Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135682AbREBRiH>; Wed, 2 May 2001 13:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135675AbREBRh7>; Wed, 2 May 2001 13:37:59 -0400
Received: from gibson.acpub.duke.edu ([152.3.233.8]:21930 "EHLO
	gibson.acpub.duke.edu") by vger.kernel.org with ESMTP
	id <S135673AbREBRhu>; Wed, 2 May 2001 13:37:50 -0400
Message-ID: <3AF04648.73F5BFCE@cds.duke.edu>
Date: Wed, 02 May 2001 13:39:20 -0400
From: Max TenEyck Woodbury <mtew@cds.duke.edu>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
			<3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> ...
> 
> If told to hold a reservation, then resend your reservation request once every
> 2 seconds (this actually has very minimal CPU/BUS usage and isn't as big a
> deal as requesting a reservation every 2 seconds might sound).  The first time
> the reservation is refused, consider the reservation stolen by another machine
> and exit (or optionally, reboot).

Umm. Reboot? What do you think this is? Windoze?

Really, You can NOT do clustering well if you don't have a consistent locking
mechanism. The use of a hardware locking method like 'reservation' may be a
good way to avoid race conditions, but it should be backed up by the 
appropriate exchange of messages to make sure everybody has the same view of
the system. For example, you might use it like this:

1. Examine the lock list for conflicts. If a conflict is found, the lock
   request fails.

2. Reserve the device with the lock on it. If the reservation fails, delay
   a short amount of time and return to 1.

3. Update the lock list for the device.

4. When the list update is complete, release the reservation.

In other words, the reservation acts as a spin-lock to make sure updates
occur atomically.

mtew@cds.duke.edu
