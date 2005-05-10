Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVEJPD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEJPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVEJPBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:01:54 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:20377 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261669AbVEJPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:01:00 -0400
Date: Tue, 10 May 2005 20:20:53 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
In-reply-to: <427FE7B3.8080200@us.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: tokunaga.keiich@jp.fujitsu.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <20050510202053.3ddd9e7b.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
 <20050420173235.GA17775@kroah.com>
 <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com>
 <20050422003920.GD6829@kroah.com>
 <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com>
 <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com>
 <20050426065431.GB5889@suse.de>
 <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
 <427FE7B3.8080200@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 May 2005 15:44:03 -0700 Matthew Dobson wrote:
> Keiichiro Tokunaga wrote:
> >   I updated the patch for 2.6.12-rc3-mm3 based on my
> > previous comments.  Please apply.
> > 
> > Thanks,
> > Keiichiro Tokunaga
> > 
> > 
> > 
> > This adds a generic function 'unregister_node()'.
> > It is used to remove objects of a node going away
> > for hotplug.
> > 
> > Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> > ---
> > 
> >  linux-2.6.12-rc3-mm3-kei/drivers/base/node.c  |   15 +++++++++++++--
> >  linux-2.6.12-rc3-mm3-kei/include/linux/node.h |    1 +
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> > --- linux-2.6.12-rc3-mm3/drivers/base/node.c~numa_hp_base	2005-05-07 19:58:15.000000000 +0900
> > +++ linux-2.6.12-rc3-mm3-kei/drivers/base/node.c	2005-05-07 19:58:15.000000000 +0900
> > @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
> >   *
> >   * Initialize and register the node device.
> >   */
> > -int __init register_node(struct node *node, int num, struct node *parent)
> > +int register_node(struct node *node, int num, struct node *parent)
> >  {
> >  	int error;
> >  
> > @@ -153,8 +153,19 @@ int __init register_node(struct node *no
> >  	return error;
> >  }
> >  
> > +void unregister_node(struct node *node)
> > +{
> > +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> > +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> > +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> > +	sysdev_remove_file(&node->sysdev, &attr_distance);
> > +
> > +	sysdev_unregister(&node->sysdev);
> > +}
> 
> Is there a reason to not make both register_node() and unregister_node()
> __devinit?  If a user has CONFIG_HOTPLUG=y then they want these functions,
> otherwise there is no point, as they promised they won't be hotplugging
> anything, right?

  The main reason is Greg advised me that we had the function
no matter if CONFIG_HOTPLUG is true or not.  An addtional
advantage of this is that the source becomes cleaner because
I included unregister_node() with '#ifdef CONFIG_HOTPLUG' and
'#endif' in my previous version of patch.

Thanks,
Keiichiro Tokunaga
