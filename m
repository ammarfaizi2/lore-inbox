Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292530AbSBTVyI>; Wed, 20 Feb 2002 16:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292528AbSBTVxv>; Wed, 20 Feb 2002 16:53:51 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:40167 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292526AbSBTVx2>; Wed, 20 Feb 2002 16:53:28 -0500
Date: Wed, 20 Feb 2002 15:10:53 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020220151053.A1198@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220145449.A1102@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 20, 2002 at 02:54:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 02:54:49PM -0700, Jeff V. Merkey wrote:

> struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
> {
> 	unsigned long addr;
> 	struct vm_struct **p, *tmp, *area;
> 
> 	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
> 	if (!area)
> 		return NULL;
> 	size += PAGE_SIZE;
> 	addr = VMALLOC_START;
> 	write_lock(&vmlist_lock);
> 	for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
>            
> ===============>  we barf here since the size + addr wraps
> 

Also, this function should be moved to the /arch/i386/mm area since
it is doing pointer arithmetic with 32 bit assumptions (i.e. 
unsigned long + unsigned long)  Last time I checked, unsigned long
was a construct for a 32 bit value in any gcc compiler version, ia64 
or not.

Jeff


> 		if ((size + addr) < addr)
> 			goto out;
> 
> 		if (size + addr <= (unsigned long) tmp->addr)
> 			break;
> 		addr = tmp->size + (unsigned long) tmp->addr;
> 		if (addr > VMALLOC_END-size)
> 			goto out;
> 	}
> 	area->flags = flags;
> 	area->addr = (void *)addr;
> 	area->size = size;
> 	area->next = *p;
> 	*p = area;
> 	write_unlock(&vmlist_lock);
> 	return area;
> 
> out:
> 	write_unlock(&vmlist_lock);
> 	kfree(area);
> 	return NULL;
> }
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> On Wed, Feb 20, 2002 at 11:00:04AM -0700, Jeff V. Merkey wrote:
> > 
> > 
> > David,
> > 
> > Someone had a thought that perhaps the Serverworks chipset is mapping 
> > addresses above the 4GB boundry.  Any thoughts on how to get around
> > this problem?  
> > 
> > Jeff
> > 
> > 
> > On Wed, Feb 20, 2002 at 09:30:34AM -0800, David S. Miller wrote:
> > >    From: Jeff Garzik <jgarzik@mandrakesoft.com>
> > >    Date: Wed, 20 Feb 2002 12:26:12 -0500
> > >    
> > >    type abuse aside, and alpha bugs aside, this looks ok... what is the
> > >    value of as->msize?
> > > 
> > > Jeff and Jeff, the problem is one of two things:
> > > 
> > > 1) when you have ~2GB of memory the vmalloc pool is very small
> > >    and this it the same place ioremap allocations come from
> > > 
> > > 2) the BIOS or Linus is not assigning resources of the device
> > >    properly, or it simple can't because the available PCI MEM space
> > >    with this much memory is too small
> > > 
> > > I note that one of the resources of the card is 16MB or so.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
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
