Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbSKQWYd>; Sun, 17 Nov 2002 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSKQWYd>; Sun, 17 Nov 2002 17:24:33 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:50818 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266972AbSKQWYc>;
	Sun, 17 Nov 2002 17:24:32 -0500
Date: Sun, 17 Nov 2002 17:34:43 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Justin A <ja6447@albany.edu>, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pnpbios oops on boot w/ 2.5.47
Message-ID: <20021117173443.GB1273@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@digeo.com>, Justin A <ja6447@albany.edu>,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <200211161700.29653.ja6447@albany.edu> <3DD6C1DC.44966373@digeo.com> <3DD6F655.4214A594@digeo.com> <20021116232528.GA1273@neo.rr.com> <3DD71CAA.E2FE9D9@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD71CAA.E2FE9D9@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 08:35:54PM -0800, Andrew Morton wrote:
> Adam Belay wrote:
> > 
> > The typo appears to be in pnpbios_set_resources.  Andrew: Is this where you
> > found it?
> 
> Well no.
> 
> > --- a/drivers/pnp/pnpbios/core.c        Wed Nov  6 17:51:53 2002
> > +++ b/drivers/pnp/pnpbios/core.c        Sat Nov 16 23:03:00 2002
> > @@ -1285,9 +1285,9 @@
> >                 return -EBUSY;
> >         if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
> >                 return -EPERM;
> > -       node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> >         if (pnp_bios_dev_node_info(&node_info) != 0)
> >                 return -ENODEV;
> > +       node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> 
> As far as I can see, max_node_size is never initialised anywhere.
>
> mnm:/usr/src/25> grep -rI max_node_size .
> ./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/core.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./drivers/pnp/pnpbios/proc.c:   node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> ./fs/reiserfs/fix_node.c:    int total_node_size, max_node_size, current_item_size;
> ./fs/reiserfs/fix_node.c:    max_node_size = MAX_CHILD_SIZE (PATH_H_PBUFFER (tb->tb_path, h));
> ./fs/reiserfs/fix_node.c:       if (i == max_node_size)
> ./fs/reiserfs/fix_node.c:       return (i / max_node_size + 1);
> ./fs/reiserfs/fix_node.c:    cur_free = max_node_size;
> ./fs/reiserfs/fix_node.c:       if (total_node_size + current_item_size <= max_node_size) {
> ./fs/reiserfs/fix_node.c:       if (current_item_size > max_node_size) {
> ./fs/reiserfs/fix_node.c:                   current_item_size, max_node_size);
> ./fs/reiserfs/fix_node.c:           free_space = max_node_size - total_node_size - IH_SIZE;
> ./include/linux/pnpbios.h:      __u16   max_node_size;

It may not appear to be initialized but in reality it actually is.  pnp_bios_dev_node_info
recieves a pointer to the node_info structure containing max_node_size.  It then passes the
pointer to __pnp_bios_dev_node_info which then passes the pointer to call_pnp_bios.
call_pnp_bios is in assembler primarily and writes data directly to the pointer almost as if
it were a buffer.  As a result the structure contains a value for max_node_size.

I appreciate your input.  Let me know if you need any additional information.

Thanks,
Adam
