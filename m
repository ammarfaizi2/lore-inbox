Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVG2AUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVG2AUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVG2AUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:20:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65530 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262171AbVG2AT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:19:58 -0400
Message-ID: <42E97616.4080501@mvista.com>
Date: Thu, 28 Jul 2005 17:19:34 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  disk quotas fail when /etc/mtab is symlinked to /proc/mounts
References: <42E97236.6080404@mvista.com>
In-Reply-To: <42E97236.6080404@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If /etc/mtab is a regular file all of the mount options (of a file 
system) are written to /etc/mtab by the mount command. The quota tools 
look there for the quota strings for their operation. If, however, 
/etc/mtab is a symlink to /proc/mounts (a "good thing" in some 
environments)  the tools don't write anything - they assume the kernel 
will take care of things.

While the quota options are sent down to the kernel via the mount system 
call and the file system codes handle them properly unfortunately there 
is no code to echo the quota strings into /proc/mounts and the quota 
tools fail in the symlink case.

The attached patchs modify the EXT[2|3] and JFS codes to add the 
necessary hooks. The show_options function of each file system in these 
patches currently deal with only those things that seemed related to 
quotas; especially in the EXT3 case more can be done (later?).

The original XFS change has been dropped as per Nathan Scott 
<nathans@sgi.com>. The functionality had already been added.

The EXT3 has added error checking and has two minor changes:
   The "quota" option is considered part of the older style quotas
   Journalled quotas and older style quotas are mutually exclusive.
   - both discussable topics

mark

Signed-off-by: Mark Bellon <mbellon@mvista.com>
