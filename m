Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVCQQ64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVCQQ64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVCQQ6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:58:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9904 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261949AbVCQQ6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:58:51 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Date: Thu, 17 Mar 2005 08:56:57 -0800
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503170856.57893.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 1:04 am, Guillaume Thouvenin wrote:
> +static inline void fork_connector(pid_t parent, pid_t child)
> +{
> + static DEFINE_SPINLOCK(cn_fork_lock);
> + static __u32 seq;   /* used to test if message is lost */
> +
> + if (cn_fork_enable) {
> +  struct cn_msg *msg;
> +
> +  __u8 buffer[CN_FORK_MSG_SIZE];
> +
> +  msg = (struct cn_msg *)buffer;
> +
> +  memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
> +  spin_lock(&cn_fork_lock);
> +  msg->seq = seq++;
> +  spin_unlock(&cn_fork_lock);

As I mentioned before, this won't work very well on a large CPU count system.  
cn_fork_lock will be taken by each CPU everytime it does a fork, meaning that 
forks will be very slow if lots of CPUs are doing them at the same time.  Is 
there a more scalable way to ensure message delivery?

Jesse
