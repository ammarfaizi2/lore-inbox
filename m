Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSETDAJ>; Sun, 19 May 2002 23:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315726AbSETDAJ>; Sun, 19 May 2002 23:00:09 -0400
Received: from panda.sul.com.br ([200.219.150.4]:46342 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S315721AbSETDAF>;
	Sun, 19 May 2002 23:00:05 -0400
Date: Sun, 19 May 2002 14:59:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        <alan@lxorguk.ukuu.org.uk>
Subject: [BK PATCH] char: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020519175930.GG6129@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	<alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E179cYq-0004I3-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 19, 2002 at 07:54:32PM -0700, Linus Torvalds escreveu:
> 	ret = copy_from_user(xxx);
> 	if (ret)
> 		return ret;

And this is what lots of the drivers I've fixed were doing... :(
 
> So a lot of people didn't get it? Arnaldo seems to have fixed a lot of
> them already, and maybe you who apparently care can add _documentation_,
> but the fact is that there is no reason to make a less powerful interface.

Ok, take some more, this time for drivers/char/*, please consider pulling it
from http://kernel-acme.bkbits.net:8080/char-copy_tofrom_user-2.5

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.568   -> 1.569  
#	  drivers/char/raw.c	1.13    -> 1.14   
#	drivers/char/istallion.c	1.7     -> 1.8    
#	drivers/char/machzwd.c	1.7     -> 1.8    
#	drivers/char/stallion.c	1.8     -> 1.9    
#	   drivers/char/sx.c	1.9     -> 1.10   
#	drivers/char/tpqic02.c	1.10    -> 1.11   
#	drivers/char/nwflash.c	1.6     -> 1.7    
#	 drivers/char/epca.c	1.9     -> 1.10   
#	drivers/char/mxser.c	1.11    -> 1.12   
#	drivers/char/n_r3964.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.569
# drivers/char/*
# 
# 	- fix copy_{to,from}_user error handling, thanks to Rusty to pointing this out on lkml
# --------------------------------------------
#
diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/epca.c	Sun May 19 23:52:14 2002
@@ -907,7 +907,9 @@
 				
 				----------------------------------------------------------------- */
 
-				copy_from_user(ch->tmp_buf, buf, bytesAvailable);
+				if (copy_from_user(ch->tmp_buf, buf,
+						   bytesAvailable))
+					return -EFAULT;
 
 			} /* End if area verified */
 
@@ -2999,7 +3001,8 @@
 				di.port = boards[brd].port ;
 				di.membase = boards[brd].membase ;
 
-				copy_to_user((char *)arg, &di, sizeof (di));
+				if (copy_to_user((char *)arg, &di, sizeof (di)))
+					return -EFAULT;
 				break;
 
 			} /* End case DIGI_GETINFO */
@@ -3068,14 +3071,9 @@
 	{ /* Begin switch cmd */
 
 		case TCGETS:
-			retval = verify_area(VERIFY_WRITE, (void *)arg,
-                              sizeof(struct termios));
-			
-			if (retval)
-				return(retval);
-
-			copy_to_user((struct termios *)arg, 
-			             tty->termios, sizeof(struct termios));
+			if (copy_to_user((struct termios *)arg, 
+					 tty->termios, sizeof(struct termios)))
+				return -EFAULT;
 			return(0);
 
 		case TCGETA:
@@ -3235,14 +3233,9 @@
 			break;
 
 		case DIGI_GETA:
-			if ((error=
-				verify_area(VERIFY_WRITE, (char*)arg, sizeof(digi_t))))
-			{
-				printk(KERN_ERR "<Error> - Digi GETA failed\n");
-				return(error);
-			}
-
-			copy_to_user((char*)arg, &ch->digiext, sizeof(digi_t));
+			if (copy_to_user((char*)arg, &ch->digiext,
+					 sizeof(digi_t)))
+				return -EFAULT;
 			break;
 
 		case DIGI_SETAW:
@@ -3263,11 +3256,9 @@
 			/* Fall Thru */
 
 		case DIGI_SETA:
-			if ((error =
-				verify_area(VERIFY_READ, (char*)arg,sizeof(digi_t))))
-				return(error);
-
-			copy_from_user(&ch->digiext, (char*)arg, sizeof(digi_t));
+			if (copy_from_user(&ch->digiext, (char*)arg,
+					   sizeof(digi_t)))
+				return -EFAULT;
 			
 			if (ch->digiext.digi_flags & DIGI_ALTPIN) 
 			{
@@ -3310,10 +3301,8 @@
 			memoff(ch);
 			restore_flags(flags);
 
-			if ((error = verify_area(VERIFY_WRITE, (char*)arg,sizeof(dflow))))
-				return(error);
-
-			copy_to_user((char*)arg, &dflow, sizeof(dflow));
+			if (copy_to_user((char*)arg, &dflow, sizeof(dflow)))
+				return -EFAULT;
 			break;
 
 		case DIGI_SETAFLOW:
@@ -3329,10 +3318,8 @@
 				stopc = ch->stopca;
 			}
 
-			if ((error = verify_area(VERIFY_READ, (char*)arg,sizeof(dflow))))
-				return(error);
-
-			copy_from_user(&dflow, (char*)arg, sizeof(dflow));
+			if (copy_from_user(&dflow, (char*)arg, sizeof(dflow)))
+				return -EFAULT;
 
 			if (dflow.startc != startc || dflow.stopc != stopc) 
 			{ /* Begin  if setflow toggled */
diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Sun May 19 23:52:13 2002
+++ b/drivers/char/istallion.c	Sun May 19 23:52:13 2002
@@ -2022,7 +2022,8 @@
 	printk("stli_setserial(portp=%x,sp=%x)\n", (int) portp, (int) sp);
 #endif
 
-	copy_from_user(&sio, sp, sizeof(struct serial_struct));
+	if (copy_from_user(&sio, sp, sizeof(struct serial_struct)))
+		return -EFAULT;
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((sio.baud_base != portp->baud_base) ||
 		    (sio.close_delay != portp->close_delay) ||
@@ -4878,11 +4879,15 @@
 	while (size > 0) {
 		memptr = (void *) EBRDGETMEMPTR(brdp, fp->f_pos);
 		n = MIN(size, (brdp->pagesize - (((unsigned long) fp->f_pos) % brdp->pagesize)));
-		copy_to_user(buf, memptr, n);
+		if (copy_to_user(buf, memptr, n)) {
+			count = -EFAULT;
+			goto out;
+		}
 		fp->f_pos += n;
 		buf += n;
 		size -= n;
 	}
+out:
 	EBRDDISABLE(brdp);
 	restore_flags(flags);
 
@@ -4930,11 +4935,15 @@
 	while (size > 0) {
 		memptr = (void *) EBRDGETMEMPTR(brdp, fp->f_pos);
 		n = MIN(size, (brdp->pagesize - (((unsigned long) fp->f_pos) % brdp->pagesize)));
-		copy_from_user(memptr, chbuf, n);
+		if (copy_from_user(memptr, chbuf, n)) {
+			count = -EFAULT;
+			goto out;
+		}
 		fp->f_pos += n;
 		chbuf += n;
 		size -= n;
 	}
+out:
 	EBRDDISABLE(brdp);
 	restore_flags(flags);
 
diff -Nru a/drivers/char/machzwd.c b/drivers/char/machzwd.c
--- a/drivers/char/machzwd.c	Sun May 19 23:52:13 2002
+++ b/drivers/char/machzwd.c	Sun May 19 23:52:13 2002
@@ -359,20 +359,15 @@
 static int zf_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
-	int ret;
-		
 	switch(cmd){
 		case WDIOC_GETSUPPORT:
-			ret = copy_to_user((struct watchdog_info *)arg, 
-						&zf_info, sizeof(zf_info));
-			if(ret)
+			if (copy_to_user((struct watchdog_info *)arg, 
+					 &zf_info, sizeof(zf_info)))
 				return -EFAULT;
 			break;
 	  
 		case WDIOC_GETSTATUS:
-			ret = copy_to_user((int *)arg, &zf_is_open,
-								sizeof(int));
-			if(ret)
+			if (copy_to_user((int *)arg, &zf_is_open, sizeof(int)))
 				return -EFAULT;
 			break;
 
diff -Nru a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/mxser.c	Sun May 19 23:52:14 2002
@@ -2175,8 +2175,7 @@
 	tmp.closing_wait = info->closing_wait;
 	tmp.custom_divisor = info->custom_divisor;
 	tmp.hub6 = 0;
-	copy_to_user(retinfo, &tmp, sizeof(*retinfo));
-	return (0);
+	return copy_to_user(retinfo, &tmp, sizeof(*retinfo)) ? -EFAULT : 0;
 }
 
 static int mxser_set_serial_info(struct mxser_struct *info,
@@ -2188,7 +2187,8 @@
 
 	if (!new_info || !info->base)
 		return (-EFAULT);
-	copy_from_user(&new_serial, new_info, sizeof(new_serial));
+	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
+		return -EFAULT;
 
 	if ((new_serial.irq != info->irq) ||
 	    (new_serial.port != info->base) ||
diff -Nru a/drivers/char/n_r3964.c b/drivers/char/n_r3964.c
--- a/drivers/char/n_r3964.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/n_r3964.c	Sun May 19 23:52:14 2002
@@ -1364,7 +1364,7 @@
       pHeader->owner = pClient;
    }
 
-   copy_from_user (pHeader->data, data, count); /* We already verified this */
+   __copy_from_user(pHeader->data, data, count); /* We already verified this */
 
    if(pInfo->flags & R3964_DEBUG)
    {
diff -Nru a/drivers/char/nwflash.c b/drivers/char/nwflash.c
--- a/drivers/char/nwflash.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/nwflash.c	Sun May 19 23:52:14 2002
@@ -159,7 +159,8 @@
 		if (ret == 0) {
 			ret = count;
 			*ppos += count;
-		}
+		} else
+			ret = -EFAULT;
 		up(&nwflash_sem);
 	}
 	return ret;
diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Sun May 19 23:52:13 2002
+++ b/drivers/char/raw.c	Sun May 19 23:52:13 2002
@@ -163,9 +163,10 @@
 
 		/* First, find out which raw minor we want */
 
-		err = copy_from_user(&rq, (void *) arg, sizeof(rq));
-		if (err)
+		if (copy_from_user(&rq, (void *) arg, sizeof(rq))) {
+			err = -EFAULT;
 			break;
+		}
 		
 		minor = rq.raw_minor;
 		if (minor <= 0 || minor > MINORMASK) {
@@ -222,6 +223,8 @@
 				rq.block_major = rq.block_minor = 0;
 			}
 			err = copy_to_user((void *) arg, &rq, sizeof(rq));
+			if (err)
+				err = -EFAULT;
 		}
 		break;
 		
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/stallion.c	Sun May 19 23:52:14 2002
@@ -1553,7 +1553,8 @@
 	printk("stl_setserial(portp=%x,sp=%x)\n", (int) portp, (int) sp);
 #endif
 
-	copy_from_user(&sio, sp, sizeof(struct serial_struct));
+	if (copy_from_user(&sio, sp, sizeof(struct serial_struct)))
+		return -EFAULT;
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((sio.baud_base != portp->baud_base) ||
 		    (sio.close_delay != portp->close_delay) ||
@@ -2949,7 +2950,8 @@
 	stlpanel_t	*panelp;
 	int		i;
 
-	copy_from_user(&stl_brdstats, bp, sizeof(combrd_t));
+	if (copy_from_user(&stl_brdstats, bp, sizeof(combrd_t)))
+		return -EFAULT;
 	if (stl_brdstats.brd >= STL_MAXBRDS)
 		return(-ENODEV);
 	brdp = stl_brds[stl_brdstats.brd];
@@ -2973,8 +2975,7 @@
 		stl_brdstats.panels[i].nrports = panelp->nrports;
 	}
 
-	copy_to_user(bp, &stl_brdstats, sizeof(combrd_t));
-	return(0);
+	return copy_to_user(bp, &stl_brdstats, sizeof(combrd_t)) ? -EFAULT : 0;
 }
 
 /*****************************************************************************/
@@ -3017,7 +3018,8 @@
 	unsigned long	flags;
 
 	if (portp == (stlport_t *) NULL) {
-		copy_from_user(&stl_comstats, cp, sizeof(comstats_t));
+		if (copy_from_user(&stl_comstats, cp, sizeof(comstats_t)))
+			return -EFAULT;
 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
 			stl_comstats.port);
 		if (portp == (stlport_t *) NULL)
@@ -3058,8 +3060,8 @@
 
 	portp->stats.signals = (unsigned long) stl_getsignals(portp);
 
-	copy_to_user(cp, &portp->stats, sizeof(comstats_t));
-	return(0);
+	return copy_to_user(cp, &portp->stats,
+			    sizeof(comstats_t)) ? -EFAULT : 0;
 }
 
 /*****************************************************************************/
@@ -3071,7 +3073,8 @@
 static int stl_clrportstats(stlport_t *portp, comstats_t *cp)
 {
 	if (portp == (stlport_t *) NULL) {
-		copy_from_user(&stl_comstats, cp, sizeof(comstats_t));
+		if (copy_from_user(&stl_comstats, cp, sizeof(comstats_t)))
+			return -EFAULT;
 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
 			stl_comstats.port);
 		if (portp == (stlport_t *) NULL)
@@ -3082,8 +3085,8 @@
 	portp->stats.brd = portp->brdnr;
 	portp->stats.panel = portp->panelnr;
 	portp->stats.port = portp->portnr;
-	copy_to_user(cp, &portp->stats, sizeof(comstats_t));
-	return(0);
+	return copy_to_user(cp, &portp->stats,
+			    sizeof(comstats_t)) ? -EFAULT : 0;
 }
 
 /*****************************************************************************/
@@ -3096,13 +3099,14 @@
 {
 	stlport_t	*portp;
 
-	copy_from_user(&stl_dummyport, (void *) arg, sizeof(stlport_t));
+	if (copy_from_user(&stl_dummyport, (void *) arg, sizeof(stlport_t)))
+		return -EFAULT;
 	portp = stl_getport(stl_dummyport.brdnr, stl_dummyport.panelnr,
 		 stl_dummyport.portnr);
 	if (portp == (stlport_t *) NULL)
 		return(-ENODEV);
-	copy_to_user((void *) arg, portp, sizeof(stlport_t));
-	return(0);
+	return copy_to_user((void *)arg, portp,
+			    sizeof(stlport_t)) ? -EFAULT : 0;
 }
 
 /*****************************************************************************/
@@ -3115,14 +3119,14 @@
 {
 	stlbrd_t	*brdp;
 
-	copy_from_user(&stl_dummybrd, (void *) arg, sizeof(stlbrd_t));
+	if (copy_from_user(&stl_dummybrd, (void *) arg, sizeof(stlbrd_t)))
+		return -EFAULT;
 	if ((stl_dummybrd.brdnr < 0) || (stl_dummybrd.brdnr >= STL_MAXBRDS))
 		return(-ENODEV);
 	brdp = stl_brds[stl_dummybrd.brdnr];
 	if (brdp == (stlbrd_t *) NULL)
 		return(-ENODEV);
-	copy_to_user((void *) arg, brdp, sizeof(stlbrd_t));
-	return(0);
+	return copy_to_user((void *)arg, brdp, sizeof(stlbrd_t)) ? -EFAULT : 0;
 }
 
 /*****************************************************************************/
diff -Nru a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/sx.c	Sun May 19 23:52:14 2002
@@ -1720,8 +1720,11 @@
 		Get_user (data,	 descr++);
 		while (nbytes && data) {
 			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
-				copy_from_user (tmp, (char *)data+i, 
-				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
+				if (copy_from_user(tmp, (char *)data + i, 
+						   (i + SX_CHUNK_SIZE >
+						    nbytes) ? nbytes - i :
+						   	      SX_CHUNK_SIZE))
+					return -EFAULT;
 				memcpy_toio    ((char *) (board->base2 + offset + i), tmp, 
 				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
 			}
diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Sun May 19 23:52:14 2002
+++ b/drivers/char/tpqic02.c	Sun May 19 23:52:14 2002
@@ -1944,12 +1944,8 @@
 			}
 			/* copy buffer to user-space in one go */
 			if (bytes_done > 0) {
-				err =
-				    copy_to_user(buf, buffaddr,
-						 bytes_done);
-				if (err) {
+				if (copy_to_user(buf, buffaddr, bytes_done))
 					return -EFAULT;
-				}
 			}
 #if 1
 			/* Checks Ton's patch below */
@@ -2085,10 +2081,8 @@
 
 		/* copy from user to DMA buffer and initiate transfer. */
 		if (bytes_todo > 0) {
-			err = copy_from_user(buffaddr, buf, bytes_todo);
-			if (err) {
+			if (copy_from_user(buffaddr, buf, bytes_todo))
 				return -EFAULT;
-			}
 
 /****************** similar problem with read() at FM could happen here at EOT.
  ******************/
