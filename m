Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWFREYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWFREYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 00:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWFREYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 00:24:37 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:4771 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932083AbWFREYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 00:24:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Wouter Paesen <wouter@kangaroot.net>
Subject: Re: [RFC][PATCH 2.6.17-rc6] input/mouse/sermouse: fix memleak and potential buffer overflow
Date: Sun, 18 Jun 2006 00:24:31 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060615104702.GA4866@tougher.kangaroot.net>
In-Reply-To: <20060615104702.GA4866@tougher.kangaroot.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606180024.32759.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 06:47, Wouter Paesen wrote:
> While strolling trough the sermouse driver for some example code, I
> noticed 2 strange things happening there :
> 
> * In the sermouse_connect function an input device structure is
>   allocated (input_allocate_device), which is not deallocated 
>   in the sermouse_disconnect function.  
>   
>   If I understand this correctly someone repeatedly connecting and 
>   disconnecting the mouse would leak input_dev structures.
>

No, input_free_device() should not be called after input_register_device()
returns successfully because input_dev will be freed automatically once
last reference to it is dropped.

> * In the sermouse_connect function the phys member of the sermouse 
>   structure (32 characters) is initialised with :
> 
>      sprintf(sermouse->phys, "%s/input0", serio->phys);
> 
>   Because serio->phys is also a 32 character field the sprintf could
>   result in 39 characters being written to the sermouse->phys.
>

Right, we need to change it to use snprintf.

-- 
Dmitry
