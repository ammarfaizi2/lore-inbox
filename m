Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTJaMUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTJaMUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:20:21 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:10767 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S263705AbTJaMT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:19:59 -0500
Date: Fri, 31 Oct 2003 13:19:56 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       <linux-kernel@vger.kernel.org>, <garloff@suse.de>,
       <matthias.andree@gmx.de>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
In-Reply-To: <20031031114616.A16435@infradead.org>
Message-ID: <Pine.LNX.4.33.0310311254530.5914-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003, Christoph Hellwig wrote:

> On Fri, Oct 31, 2003 at 12:25:08PM +0100, Guennadi Liakhovetski wrote:
> > > > +#ifdef AM53C974_MULTIPLE_CARD
> > > > +#error "FIXME! Multiple card support is broken. Looks like it never
> > > really worked. Might have to be fixed."
> > > >  static struct Scsi_Host *first_host;	/* Head of list of AMD boards */
> > > > +#endif
> > >
> > > Why do you need the undef?  It looks like you need to kill a #define for
> > > this symbol somewhere else :)
> >
> > So that, when it is fixed, somebody can easily switch it on / off:-)
>
> Then just comment ou the #define.  Rule of the thumb:  #undef always means
> you screwed up elsewhere :)

Grrrr... Commented out code...

> cli() disabled all intereupts in 2.4 which was safe, you only disable local

Auch, ok, forgot, that cli() was global in 2.4, thanks for reminding, I
don't work with SMPs due to the lack thereof:-(

> Oh.  What driver did you find this construct in?

grep... (maybe not all of them are real hits, but, most of them do
certainly look very much like what I've done). BTW, I also saw arrays of
cards in some drvers, which also doesn't correspond to your suggestions:

drivers/scsi/arm/scsi.h-41-		SCp->ptr = (char *)
drivers/scsi/arm/scsi.h:42:			 (page_address(SCp->buffer->page) +
drivers/scsi/arm/scsi.h-43-			  SCp->buffer->offset);
--
drivers/scsi/arm/scsi.h-79-		SCpnt->SCp.ptr = (char *)
drivers/scsi/arm/scsi.h:80:			 (page_address(SCpnt->SCp.buffer->page) +
drivers/scsi/arm/scsi.h-81-			  SCpnt->SCp.buffer->offset);
--
drivers/scsi/sg.c-1071-	return (sclp && sclp->page) ?
drivers/scsi/sg.c:1072:	    (unsigned char *) page_address(sclp->page) + sclp->offset : NULL;
--
drivers/scsi/st.c:3517:		res = copy_from_user(page_address(st_bp->frp[i].page) + offset, ubp, cnt);
--
drivers/scsi/st.c:3550:		res = copy_to_user(ubp, page_address(st_bp->frp[i].page) + offset, cnt);
--
drivers/scsi/st.c:3593:		memmove(page_address(st_bp->frp[dst_seg].page) + dst_offset,
drivers/scsi/st.c:3594:			page_address(st_bp->frp[src_seg].page) + src_offset, count);
--
drivers/scsi/scsi_debug.c:260:		return (unsigned char *)page_address(sclp->page) +
drivers/scsi/scsi_debug.c-261-		       sclp->offset;
--
drivers/scsi/in2000.c:377:		cmd->SCp.ptr = (char *) page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/in2000.c:769:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/ide-scsi.c:149:		buf = page_address(pc->sg->page) + pc->sg->offset;
--
drivers/scsi/ide-scsi.c:171:		buf = page_address(pc->sg->page) + pc->sg->offset;
--
drivers/scsi/NCR53C9x.c:924:				(char *) virt_to_phys((page_address(sp->SCp.buffer->page) + sp->SCp.buffer->offset));
--
drivers/scsi/NCR53C9x.c:1758:		sp->SCp.ptr = (char *) virt_to_phys((page_address(sp->SCp.buffer->page) + sp->SCp.buffer->offset));
--
drivers/scsi/imm.c:840:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/imm.c:981:	    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/ips.c:215:#define IPS_SG_ADDRESS(sg)      (page_address((sg)->page) ? \
drivers/scsi/ips.c:216:                                     page_address((sg)->page)+(sg)->offset : 0)
--
drivers/scsi/ppa.c:752:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/ppa.c:903:	    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/qlogicfas.c:426:				buf = page_address(sglist->page) + sglist->offset;
--
drivers/scsi/sun3x_esp.c:349:	    sg[sz].dvma_address = dvma_map((unsigned long)page_address(sg[sz].page) +
drivers/scsi/sun3x_esp.c-350-					   sg[sz].offset, sg[sz].length);
--
drivers/scsi/aha1542.c:72:	       page_address(sgpnt[badseg].page) + sgpnt[badseg].offset,
--
drivers/scsi/aha1542.c:719:					       (page_address(sgpnt[i].page) +
drivers/scsi/aha1542.c-720-						sgpnt[i].offset),
--
drivers/scsi/aha152x.c:584:#define SG_ADDRESS(buffer)	((char *) (page_address((buffer)->page)+(buffer)->offset))
--
drivers/scsi/oktagon_esp.c:559:        sp->SCp.ptr = page_address(sp->SCp.buffer->page)+
drivers/scsi/oktagon_esp.c-560-		      sp->SCp.buffer->offset;
--
drivers/scsi/oktagon_esp.c:573:	sp->SCp.ptr = page_address(sp->SCp.buffer->page)+
drivers/scsi/oktagon_esp.c-574-		      sp->SCp.buffer->offset;
--
drivers/scsi/megaraid.c:2040:					page_address((&sgl[0])->page) +
drivers/scsi/megaraid.c-2041-					(&sgl[0])->offset;
--
drivers/scsi/fd_mcs.c:1024:					current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
--
drivers/scsi/fd_mcs.c:1057:				current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
--
drivers/scsi/fd_mcs.c:1160:		current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
--
drivers/scsi/dc395x.c:238:#define CPU_ADDR(sg)		(page_address((sg).page)+(sg).offset)
--
drivers/scsi/sun3_NCR5380.c:273:#define SGADDR(buffer) (void *)(((unsigned long)page_address((buffer)->page)) + \
drivers/scsi/sun3_NCR5380.c-274-			(buffer)->offset)
--
drivers/scsi/seagate.c:989:					     page_address(buffer[i].page) + buffer[i].offset,
--
drivers/scsi/seagate.c:996:			data = page_address(buffer->page) + buffer->offset;
--
drivers/scsi/seagate.c:1243:					data = page_address(buffer->page) + buffer->offset;
--
drivers/scsi/seagate.c:1417:					data = page_address(buffer->page) + buffer->offset;
--
drivers/scsi/fdomain.c:1294:	       current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
--
drivers/scsi/fdomain.c:1327:	    current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
--
drivers/scsi/fdomain.c:1413:      current_SC->SCp.ptr              = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
--
drivers/scsi/osst.c:4280:		STp->buffer->aux = (os_aux_t *) (page_address(STp->buffer->sg[i].page) + OS_DATA_SIZE - b_size);
--
drivers/scsi/osst.c:5146:		res = copy_from_user(page_address(st_bp->sg[i].page) + offset, ubp, cnt);
--
drivers/scsi/osst.c:5179:		res = copy_to_user(ubp, page_address(st_bp->sg[i].page) + offset, cnt);
--
drivers/scsi/osst.c:5212:		memset(page_address(st_bp->sg[i].page) + offset, 0, cnt);
--
drivers/scsi/NCR53c406a.c:884:					NCR53c406a_pio_write(page_address(sglist->page) + sglist->offset, sglist->length);
--
drivers/scsi/NCR53c406a.c:911:					NCR53c406a_pio_read(page_address(sglist->page) + sglist->offset, sglist->length);
--
drivers/scsi/atari_NCR5380.c:472:	 virt_to_phys(page_address(cmd->SCp.buffer[1].page)+
drivers/scsi/atari_NCR5380.c-473-		      cmd->SCp.buffer[1].offset) == endaddr; ) {
--
drivers/scsi/atari_NCR5380.c:510:	cmd->SCp.ptr = (char *)page_address(cmd->SCp.buffer->page)+
drivers/scsi/atari_NCR5380.c-511-		       cmd->SCp.buffer->offset;
--
drivers/scsi/atari_NCR5380.c:2044:		    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page)+
drivers/scsi/atari_NCR5380.c-2045-				   cmd->SCp.buffer->offset;
--
drivers/scsi/sym53c416.c:200:#define SG_ADDRESS(buffer)     ((char *) (page_address((buffer)->page)+(buffer)->offset))
--
drivers/scsi/53c7xx.c:3453:	    ? (u32)page_address(((struct scatterlist *)cmd->buffer)[i].page)+
drivers/scsi/53c7xx.c-3454-	      ((struct scatterlist *)cmd->buffer)[i].offset
--
drivers/scsi/53c7xx.c:5420:    	    	     buffers && !((found = ((ptr >= (char *)page_address(segment->page)+segment->offset) &&
drivers/scsi/53c7xx.c:5421:    	    	    	    (ptr < ((char *)page_address(segment->page)+segment->offset+segment->length)))));
--
drivers/scsi/53c7xx.c:5425:			cmd->device->host->host_no, saved, page_address(segment->page+segment->offset);
--
drivers/scsi/53c7xx.c:5429:    	    	    offset += ptr - ((char *)page_address(segment->page)+segment->offset);
--
drivers/scsi/eata_pio.c:184:			SCp->ptr = page_address(SCp->buffer->page) + SCp->buffer->offset;
--
drivers/scsi/eata_pio.c:417:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
--
drivers/scsi/NCR5380.c:337:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page)+
drivers/scsi/NCR5380.c-338-			       cmd->SCp.buffer->offset;
--
drivers/scsi/NCR5380.c:2338:					cmd->SCp.ptr = page_address(cmd->SCp.buffer->page)+
drivers/scsi/NCR5380.c-2339-						       cmd->SCp.buffer->offset;
--
drivers/scsi/wd33c93.c:388:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) +
drivers/scsi/wd33c93.c-389-		    cmd->SCp.buffer->offset;
--
drivers/scsi/wd33c93.c:721:		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) +
drivers/scsi/wd33c93.c-722-		    cmd->SCp.buffer->offset;
--
drivers/scsi/advansys.c:6728:		(unsigned char *)page_address(slp->page) + slp->offset));
--
drivers/scsi/advansys.c:6987:                   (unsigned char *)page_address(slp->page) + slp->offset));

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

