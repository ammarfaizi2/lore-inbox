Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292523AbSBTVhs>; Wed, 20 Feb 2002 16:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292522AbSBTVhi>; Wed, 20 Feb 2002 16:37:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:36839 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292518AbSBTVhX>; Wed, 20 Feb 2002 16:37:23 -0500
Date: Wed, 20 Feb 2002 14:54:49 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020220145449.A1102@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220110004.A32431@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 20, 2002 at 11:00:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The following information is submitted regarding this problem:

I have corrected the prefetch allocation problem by reducing 
the prefetch address space size from 512 MB down to 32 MB.  The
failing code is in get_vm_area().  This bug effectively reduces
the ability of Linux over other OS's to run scalable SCI based
applications with large numbers of nodes if there are large numbers
of nodes in a cluster and these nodes have more than 1 GB of memory
in each system.  

My RAID/FS application does not need a huge prefetch address space so I 
can get around this problem easily, but some of the SCI applications do, 
and this problem will relegate Linux to a back seat status for supercomputer 
applications that use this technology if Linux in unable to map larger 
regions of memory.  I would propose that the maintainer of 
vmalloc.c look at using 48 bit PTE entries or some other solution 
as a way to alloc larger virtual address frames when the system has 
a lot of physical memory.  It's seems pretty lame to me for a machine 
with 2 GB of physical memory not to have at lest 256 MB of address space
left over for address mapping.  

Offending code attached.  Please advise as to what a proposed solution
could be if any is possible with this problem.  I am happy to adjust
the Dolphin IRM driver behavior to accomodate Linux but I think some 
larger clusters (i.e. > 1000 nodes) may not work with Linux is there's
not enough address space to map remotely across the cluster.

Jeff


struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
{
	unsigned long addr;
	struct vm_struct **p, *tmp, *area;

	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
	if (!area)
		return NULL;
	size += PAGE_SIZE;
	addr = VMALLOC_START;
	write_lock(&vmlist_lock);
	for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
           
===============>  we barf here since the size + addr wraps

		if ((size + addr) < addr)
			goto out;

		if (size + addr <= (unsigned long) tmp->addr)
			break;
		addr = tmp->size + (unsigned long) tmp->addr;
		if (addr > VMALLOC_END-size)
			goto out;
	}
	area->flags = flags;
	area->addr = (void *)addr;
	area->size = size;
	area->next = *p;
	*p = area;
	write_unlock(&vmlist_lock);
	return area;

out:
	write_unlock(&vmlist_lock);
	kfree(area);
	return NULL;
}











On Wed, Feb 20, 2002 at 11:00:04AM -0700, Jeff V. Merkey wrote:
> 
> 
> David,
> 
> Someone had a thought that perhaps the Serverworks chipset is mapping 
> addresses above the 4GB boundry.  Any thoughts on how to get around
> this problem?  
> 
> Jeff
> 
> 
> On Wed, Feb 20, 2002 at 09:30:34AM -0800, David S. Miller wrote:
> >    From: Jeff Garzik <jgarzik@mandrakesoft.com>
> >    Date: Wed, 20 Feb 2002 12:26:12 -0500
> >    
> >    type abuse aside, and alpha bugs aside, this looks ok... what is the
> >    value of as->msize?
> > 
> > Jeff and Jeff, the problem is one of two things:
> > 
> > 1) when you have ~2GB of memory the vmalloc pool is very small
> >    and this it the same place ioremap allocations come from
> > 
> > 2) the BIOS or Linus is not assigning resources of the device
> >    properly, or it simple can't because the available PCI MEM space
> >    with this much memory is too small
> > 
> > I note that one of the resources of the card is 16MB or so.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
