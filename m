Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTEZGWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTEZGWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:22:05 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:34721 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264303AbTEZGV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:21:27 -0400
Date: Mon, 26 May 2003 01:45:16 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/* strlcpy conversions
Message-ID: <20030526054516.GR2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this is it for me and strlcpy. I'll leave the rest of the
non-obvious usages of strncpy to the kernel janitors. Seems like quite a
few uses really wanted memcpy instead, but I don't have time to
investigate them all. It does appear that nearly all strncpy's will be
removable. Obsoleting strncpy will probably atleast make the remaining
few think about how they are using it.

This is the patch for my trip through drivers/*.


Index: linux-2.5/drivers/media/video/zr36067.c
===================================================================
--- linux-2.5/drivers/media/video/zr36067.c	(revision 10182)
+++ linux-2.5/drivers/media/video/zr36067.c	(working copy)
@@ -3356,7 +3356,7 @@
 			struct video_capability b;
 			DEBUG2(printk("%s: ioctl VIDIOCGCAP\n", zr->name));
 
-			strncpy(b.name, zr->video_dev.name,
+			strlcpy(b.name, zr->video_dev.name,
 				sizeof(b.name));
 			b.type =
 			    VID_TYPE_CAPTURE | VID_TYPE_OVERLAY |
Index: linux-2.5/drivers/media/video/bttv-driver.c
===================================================================
--- linux-2.5/drivers/media/video/bttv-driver.c	(revision 10182)
+++ linux-2.5/drivers/media/video/bttv-driver.c	(working copy)
@@ -2309,7 +2309,7 @@
 		if (0 == v4l2)
 			return -EINVAL;
                 strcpy(cap->driver,"bttv");
-                strncpy(cap->card,btv->video_dev.name,sizeof(cap->card));
+                strlcpy(cap->card,btv->video_dev.name,sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",btv->dev->slot_name);
 		cap->version = BTTV_VERSION_CODE;
 		cap->capabilities =
@@ -2367,7 +2367,7 @@
 		f->index       = index;
 		f->type        = type;
 		f->pixelformat = bttv_formats[i].fourcc;
-		strncpy(f->description,bttv_formats[i].name,31);
+		strlcpy(f->description,bttv_formats[i].name,sizeof(f->description));
 		return 0;
 	}
 
Index: linux-2.5/drivers/media/video/saa7185.c
===================================================================
--- linux-2.5/drivers/media/video/saa7185.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa7185.c	(working copy)
@@ -202,7 +202,7 @@
 
 
 	memset(encoder, 0, sizeof(*encoder));
-	strncpy(client->dev.name, "saa7185", DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, "saa7185", DEVICE_NAME_SIZE);
 	encoder->client = client;
 	i2c_set_clientdata(client, encoder);
 	encoder->addr = addr;
Index: linux-2.5/drivers/media/video/adv7175.c
===================================================================
--- linux-2.5/drivers/media/video/adv7175.c	(revision 10182)
+++ linux-2.5/drivers/media/video/adv7175.c	(working copy)
@@ -191,7 +191,7 @@
 		// We should never get here!!!
 		dname = unknown_name;
 	}
-	strncpy(client->dev.name, dname, DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, dname, DEVICE_NAME_SIZE);
 	init_MUTEX(&encoder->lock);
 	encoder->client = client;
 	i2c_set_clientdata(client, encoder);
Index: linux-2.5/drivers/media/video/saa7134/saa7134-oss.c
===================================================================
--- linux-2.5/drivers/media/video/saa7134/saa7134-oss.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa7134/saa7134-oss.c	(working copy)
@@ -636,8 +636,8 @@
 	{
 		mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,   "TV audio", sizeof(info.id)-1);
-                strncpy(info.name, dev->name,  sizeof(info.name)-1);
+                strlcpy(info.id,   "TV audio", sizeof(info.id));
+                strlcpy(info.name, dev->name,  sizeof(info.name));
                 info.modify_counter = dev->oss.count;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -647,8 +647,8 @@
 	{
 		_old_mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,   "TV audio", sizeof(info.id)-1);
-                strncpy(info.name, dev->name,  sizeof(info.name)-1);
+                strlcpy(info.id,   "TV audio", sizeof(info.id));
+                strlcpy(info.name, dev->name,  sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
 		return 0;
Index: linux-2.5/drivers/media/video/saa7134/saa7134-video.c
===================================================================
--- linux-2.5/drivers/media/video/saa7134/saa7134-video.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa7134/saa7134-video.c	(working copy)
@@ -1501,7 +1501,7 @@
 		
 		memset(cap,0,sizeof(*cap));
                 strcpy(cap->driver, "saa7134");
-		strncpy(cap->card, saa7134_boards[dev->board].name,
+		strlcpy(cap->card, saa7134_boards[dev->board].name,
 			sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",dev->pci->slot_name);
 		cap->version = SAA7134_VERSION_CODE;
@@ -1733,7 +1733,7 @@
 			memset(f,0,sizeof(*f));
 			f->index = index;
 			f->type  = type;
-			strncpy(f->description,formats[index].name,31);
+			strlcpy(f->description,formats[index].name,sizeof(f->description));
 			f->pixelformat = formats[index].fourcc;
 			break;
 		case V4L2_BUF_TYPE_VBI_CAPTURE:
@@ -1901,7 +1901,7 @@
 
 		memset(cap,0,sizeof(*cap));
                 strcpy(cap->driver, "saa7134");
-		strncpy(cap->card, saa7134_boards[dev->board].name,
+		strlcpy(cap->card, saa7134_boards[dev->board].name,
 			sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",dev->pci->slot_name);
 		cap->version = SAA7134_VERSION_CODE;
Index: linux-2.5/drivers/media/video/saa7134/saa7134-ts.c
===================================================================
--- linux-2.5/drivers/media/video/saa7134/saa7134-ts.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa7134/saa7134-ts.c	(working copy)
@@ -251,7 +251,7 @@
 
 		memset(cap,0,sizeof(*cap));
                 strcpy(cap->driver, "saa7134");
-		strncpy(cap->card, saa7134_boards[dev->board].name,
+		strlcpy(cap->card, saa7134_boards[dev->board].name,
 			sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",dev->pci->slot_name);
 		cap->version = SAA7134_VERSION_CODE;
@@ -300,7 +300,7 @@
 		
 		memset(f,0,sizeof(*f));
 		f->index = index;
-		strncpy(f->description, "MPEG TS", 31);
+		strlcpy(f->description, "MPEG TS", sizeof(f->description));
 		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		f->pixelformat = V4L2_PIX_FMT_MPEG;
 		return 0;
Index: linux-2.5/drivers/media/video/bt856.c
===================================================================
--- linux-2.5/drivers/media/video/bt856.c	(revision 10182)
+++ linux-2.5/drivers/media/video/bt856.c	(working copy)
@@ -123,7 +123,7 @@
 
 
 	memset(encoder, 0, sizeof(struct bt856));
-	strncpy(client->dev.name, "bt856", DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, "bt856", DEVICE_NAME_SIZE);
 	encoder->client = client;
 	i2c_set_clientdata(client, encoder);
 	encoder->addr = client->addr;
Index: linux-2.5/drivers/media/video/saa7110.c
===================================================================
--- linux-2.5/drivers/media/video/saa7110.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa7110.c	(working copy)
@@ -176,7 +176,7 @@
 
 	/* clear our private data */
 	memset(decoder, 0, sizeof(*decoder));
-	strncpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
 	decoder->client = client;
 	i2c_set_clientdata(client, decoder);
 	decoder->addr = addr;
Index: linux-2.5/drivers/media/video/v4l2-common.c
===================================================================
--- linux-2.5/drivers/media/video/v4l2-common.c	(revision 10182)
+++ linux-2.5/drivers/media/video/v4l2-common.c	(working copy)
@@ -113,7 +113,7 @@
 		vs->frameperiod.denominator = 25;
 		vs->framelines = 625;
 	}
-	strncpy(vs->name,name,sizeof(vs->name));
+	strlcpy(vs->name,name,sizeof(vs->name));
 	return 0;
 }
 
Index: linux-2.5/drivers/media/video/saa5249.c
===================================================================
--- linux-2.5/drivers/media/video/saa5249.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa5249.c	(working copy)
@@ -171,7 +171,7 @@
 		return -ENOMEM;
 	}
 	memset(t, 0, sizeof(*t));
-	strncpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, IF_NAME, DEVICE_NAME_SIZE);
 	init_MUTEX(&t->lock);
 	
 	/*
Index: linux-2.5/drivers/media/video/tvmixer.c
===================================================================
--- linux-2.5/drivers/media/video/tvmixer.c	(revision 10182)
+++ linux-2.5/drivers/media/video/tvmixer.c	(working copy)
@@ -83,8 +83,8 @@
 	
         if (cmd == SOUND_MIXER_INFO) {
                 mixer_info info;
-                strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, i2c_clientname(client), sizeof(info.name));
+                strlcpy(info.id, "tv card", sizeof(info.id));
+                strlcpy(info.name, i2c_clientname(client), sizeof(info.name));
                 info.modify_counter = 42 /* FIXME */;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -92,8 +92,8 @@
         }
         if (cmd == SOUND_OLD_MIXER_INFO) {
                 _old_mixer_info info;
-                strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, i2c_clientname(client), sizeof(info.name));
+                strlcpy(info.id, "tv card", sizeof(info.id));
+                strlcpy(info.name, i2c_clientname(client), sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
                 return 0;
Index: linux-2.5/drivers/media/video/bt819.c
===================================================================
--- linux-2.5/drivers/media/video/bt819.c	(revision 10182)
+++ linux-2.5/drivers/media/video/bt819.c	(working copy)
@@ -172,7 +172,7 @@
 	}
 
 	memset(decoder, 0, sizeof(struct bt819));
-	strncpy(client->dev.name, "bt819", DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, "bt819", DEVICE_NAME_SIZE);
 	i2c_set_clientdata(client, decoder);
 	decoder->client = client;
 	decoder->addr = addr;
Index: linux-2.5/drivers/media/video/saa7111.c
===================================================================
--- linux-2.5/drivers/media/video/saa7111.c	(revision 10182)
+++ linux-2.5/drivers/media/video/saa7111.c	(working copy)
@@ -122,7 +122,7 @@
 	}
 
 	memset(decoder, 0, sizeof(*decoder));
-	strncpy(client->dev.name, "saa7111", DEVICE_NAME_SIZE);
+	strlcpy(client->dev.name, "saa7111", DEVICE_NAME_SIZE);
 	decoder->client = client;
 	i2c_set_clientdata(client, decoder);
 	decoder->addr = addr;
Index: linux-2.5/drivers/media/video/tuner.c
===================================================================
--- linux-2.5/drivers/media/video/tuner.c	(revision 10182)
+++ linux-2.5/drivers/media/video/tuner.c	(working copy)
@@ -824,7 +824,7 @@
 	if (type < TUNERS) {
 		t->type = type;
 		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
-		strncpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
 	}
         i2c_attach_client(client);
         if (t->type == TUNER_MT2032)
@@ -875,7 +875,7 @@
 		t->type = *iarg;
 		printk("tuner: type set to %d (%s)\n",
                         t->type,tuners[t->type].name);
-		strncpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
 		if (t->type == TUNER_MT2032)
                         mt2032_init(client);
 		break;
Index: linux-2.5/drivers/media/common/saa7146_video.c
===================================================================
--- linux-2.5/drivers/media/common/saa7146_video.c	(revision 10182)
+++ linux-2.5/drivers/media/common/saa7146_video.c	(working copy)
@@ -801,7 +801,7 @@
 		DEB_EE(("VIDIOC_QUERYCAP\n"));
 		
                 strcpy(cap->driver, "saa7146 v4l2");
-		strncpy(cap->card, dev->ext->name, sizeof(cap->card));
+		strlcpy(cap->card, dev->ext->name, sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",dev->pci->slot_name);
 		cap->version = SAA7146_VERSION_CODE;
 		cap->capabilities =
@@ -868,7 +868,7 @@
 			}
 			memset(f,0,sizeof(*f));
 			f->index = index;
-			strncpy(f->description,formats[index].name,31);
+			strlcpy(f->description,formats[index].name,sizeof(f->description));
 			f->pixelformat = formats[index].pixelformat;
 			break;
 		}
Index: linux-2.5/drivers/media/common/saa7146_fops.c
===================================================================
--- linux-2.5/drivers/media/common/saa7146_fops.c	(revision 10182)
+++ linux-2.5/drivers/media/common/saa7146_fops.c	(working copy)
@@ -430,7 +430,7 @@
 	DEB_EE(("dev:%p, name:'%s'\n",dev,name));
  
  	*vid = device_template;
-	strncpy(vid->name, name, 32);
+	strlcpy(vid->name, name, sizeof(vid->name));
 	vid->priv = dev;
 
 	// fixme: -1 should be an insmod parameter *for the extension* (like "video_nr");
Index: linux-2.5/drivers/hotplug/pci_hotplug_core.c
===================================================================
--- linux-2.5/drivers/hotplug/pci_hotplug_core.c	(revision 10182)
+++ linux-2.5/drivers/hotplug/pci_hotplug_core.c	(working copy)
@@ -529,7 +529,7 @@
 	if ((slot->info == NULL) || (slot->ops == NULL))
 		return -EINVAL;
 
-	strncpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
+	strlcpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
 	kobj_set_kset_s(slot, hotplug_slots_subsys);
 
 	/* this can fail if we have already registered a slot with the same name */
Index: linux-2.5/drivers/message/fusion/mptctl.c
===================================================================
--- linux-2.5/drivers/message/fusion/mptctl.c	(revision 10182)
+++ linux-2.5/drivers/message/fusion/mptctl.c	(working copy)
@@ -1317,7 +1317,7 @@
 
 	/* Set the Version Strings.
 	 */
-	strncpy (karg.driverVersion, MPT_LINUX_PACKAGE_NAME, MPT_IOCTL_VERSION_LENGTH);
+	strlcpy (karg.driverVersion, MPT_LINUX_PACKAGE_NAME, MPT_IOCTL_VERSION_LENGTH);
 
 	karg.busChangeEvent = 0;
 	karg.hostId = ioc->pfacts[port].PortSCSIID;
@@ -1517,8 +1517,8 @@
 #else
 	karg.chip_type = ioc->chip_type;
 #endif
-	strncpy (karg.name, ioc->name, MPT_MAX_NAME);
-	strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
+	strlcpy (karg.name, ioc->name, MPT_MAX_NAME);
+	strlcpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
 
 	/* Copy the data from kernel memory to user memory
 	 */
@@ -2488,7 +2488,7 @@
 	cfg.dir = 0;	/* read */
 	cfg.timeout = 10;
 
-	strncpy(karg.serial_number, " ", 24);
+	strlcpy(karg.serial_number, " ", sizeof(karg.serial_number));
 	if (mpt_config(ioc, &cfg) == 0) {
 		if (cfg.hdr->PageLength > 0) {
 			/* Issue the second config page request */
@@ -2500,7 +2500,8 @@
 				if (mpt_config(ioc, &cfg) == 0) {
 					ManufacturingPage0_t *pdata = (ManufacturingPage0_t *) pbuf;
 					if (strlen(pdata->BoardTracerNumber) > 1)
-						strncpy(karg.serial_number, pdata->BoardTracerNumber, 24);
+						strlcpy(karg.serial_number, pdata->BoardTracerNumber,
+							sizeof(karg.serial_number));
 				}
 				pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, pbuf, buf_dma);
 				pbuf = NULL;
Index: linux-2.5/drivers/mtd/cmdline.c
===================================================================
--- linux-2.5/drivers/mtd/cmdline.c	(revision 10182)
+++ linux-2.5/drivers/mtd/cmdline.c	(working copy)
@@ -187,8 +187,7 @@
 	parts[this_part].mask_flags = mask_flags;
 	if (name)
 	{
-		strncpy(extra_mem, name, name_len);
-		extra_mem[name_len] = 0;
+		strlcpy(extra_mem, name, name_len + 1);
 	}
 	else
 	{
@@ -267,8 +266,7 @@
 		this_mtd->parts = parts;
 		this_mtd->num_parts = num_parts;
 		this_mtd->mtd_id = (char*)(this_mtd + 1);
-		strncpy(this_mtd->mtd_id, mtd_id, mtd_id_len);
-		this_mtd->mtd_id[mtd_id_len] = 0;
+		strlcpy(this_mtd->mtd_id, mtd_id, mtd_id_len + 1);
 
 		/* link into chain */
 		this_mtd->next = partitions;	    	
Index: linux-2.5/drivers/mtd/chips/jedec.c
===================================================================
--- linux-2.5/drivers/mtd/chips/jedec.c	(revision 10182)
+++ linux-2.5/drivers/mtd/chips/jedec.c	(working copy)
@@ -168,8 +168,7 @@
    /* Generate a part name that includes the number of different chips and
       other configuration information */
    count = 1;
-   strncpy(Part,map->name,sizeof(Part)-10);
-   Part[sizeof(Part)-11] = 0;
+   strlcpy(Part,map->name,sizeof(Part)-10);
    strcat(Part," ");
    Uniq = 0;
    for (I = 0; priv->chips[I].jedec != 0 && I < MAX_JEDEC_CHIPS; I++)
@@ -246,8 +245,7 @@
    //   printk("Part: '%s'\n",Part);
    
    memset(MTD,0,sizeof(*MTD));
-  // strncpy(MTD->name,Part,sizeof(MTD->name));
-  // MTD->name[sizeof(MTD->name)-1] = 0;
+  // strlcpy(MTD->name,Part,sizeof(MTD->name));
    MTD->name = map->name;
    MTD->type = MTD_NORFLASH;
    MTD->flags = MTD_CAP_NORFLASH;
Index: linux-2.5/drivers/isdn/isdnloop/isdnloop.c
===================================================================
--- linux-2.5/drivers/isdn/isdnloop/isdnloop.c	(revision 10182)
+++ linux-2.5/drivers/isdn/isdnloop/isdnloop.c	(working copy)
@@ -125,7 +125,7 @@
 	char *s = strpbrk(t, ",");
 
 	*s++ = '\0';
-	strncpy(cmd->parm.setup.phone, t, sizeof(cmd->parm.setup.phone));
+	strlcpy(cmd->parm.setup.phone, t, sizeof(cmd->parm.setup.phone));
 	s = strpbrk(t = s, ",");
 	*s++ = '\0';
 	if (!strlen(t))
@@ -139,7 +139,7 @@
 	else
 		cmd->parm.setup.si2 =
 		    simple_strtoul(t, NULL, 10);
-	strncpy(cmd->parm.setup.eazmsn, s, sizeof(cmd->parm.setup.eazmsn));
+	strlcpy(cmd->parm.setup.eazmsn, s, sizeof(cmd->parm.setup.eazmsn));
 	cmd->parm.setup.plan = 0;
 	cmd->parm.setup.screen = 0;
 }
@@ -228,21 +228,21 @@
 			break;
 		case 5:
 			/* CIF */
-			strncpy(cmd.parm.num, status + 3, sizeof(cmd.parm.num) - 1);
+			strlcpy(cmd.parm.num, status + 3, sizeof(cmd.parm.num));
 			break;
 		case 6:
 			/* AOC */
-			sprintf(cmd.parm.num, "%d",
+			snprintf(cmd.parm.num, sizeof(cmd.parm.num), "%d",
 			     (int) simple_strtoul(status + 7, NULL, 16));
 			break;
 		case 7:
 			/* CAU */
 			status += 3;
 			if (strlen(status) == 4)
-				sprintf(cmd.parm.num, "%s%c%c",
+				snprintf(cmd.parm.num, sizeof(cmd.parm.num), "%s%c%c",
 				     status + 2, *status, *(status + 1));
 			else
-				strncpy(cmd.parm.num, status + 1, sizeof(cmd.parm.num) - 1);
+				strlcpy(cmd.parm.num, status + 1, sizeof(cmd.parm.num));
 			break;
 		case 8:
 			/* Misc Errors on L1 and L2 */
@@ -1467,7 +1467,7 @@
 	    ISDN_FEATURE_L3_TRANS |
 	    ISDN_FEATURE_P_UNKNOWN;
 	card->ptype = ISDN_PTYPE_UNKNOWN;
-	strncpy(card->interface.id, id, sizeof(card->interface.id) - 1);
+	strlcpy(card->interface.id, id, sizeof(card->interface.id));
 	card->msg_buf_write = card->msg_buf;
 	card->msg_buf_read = card->msg_buf;
 	card->msg_buf_end = &card->msg_buf[sizeof(card->msg_buf) - 1];
Index: linux-2.5/drivers/isdn/i4l/isdn_net_lib.c
===================================================================
--- linux-2.5/drivers/isdn/i4l/isdn_net_lib.c	(revision 10182)
+++ linux-2.5/drivers/isdn/i4l/isdn_net_lib.c	(working copy)
@@ -270,8 +270,7 @@
 	int chidx = -1;
 	char drvid[25];
 
-	strncpy(drvid, cfg->drvid, 24);
-	drvid[24] = 0;
+	strlcpy(drvid, cfg->drvid, sizeof(drvid));
 
 	if (cfg->exclusive && !strlen(drvid)) {
 		/* If we want to bind exclusively, need to specify drv/chan */
@@ -562,8 +561,7 @@
 	if (retval)
 		goto out;
 
-	strncpy(mlp->msn, cfg->eaz, ISDN_MSNLEN-1);
-	mlp->msn[ISDN_MSNLEN-1] = 0;
+	strlcpy(mlp->msn, cfg->eaz, sizeof(mlp->msn));
 	mlp->onhtime = cfg->onhtime;
 	idev->charge = cfg->charge;
 	mlp->l2_proto = cfg->l2_proto;
@@ -864,7 +862,7 @@
 
 	slot = idev->isdn_slot;
 
-	strncpy(phone->phone, slot->num, ISDN_MSNLEN);
+	strlcpy(phone->phone, slot->num, sizeof(phone->phone));
 	phone->outgoing = USG_OUTGOING(slot->usage);
 
 	if (copy_to_user(peer, phone, sizeof(*peer)))
Index: linux-2.5/drivers/isdn/i4l/isdn_ppp.c
===================================================================
--- linux-2.5/drivers/isdn/i4l/isdn_ppp.c	(revision 10182)
+++ linux-2.5/drivers/isdn/i4l/isdn_ppp.c	(working copy)
@@ -467,11 +467,11 @@
 		memset(&pci, 0, sizeof(pci));
 
 		mlp = idev->mlp;
-		strncpy(pci.local_num, mlp->msn, 63);
+		strlcpy(pci.local_num, mlp->msn, sizeof(pci.local_num));
 		i = 0;
 		list_for_each_entry(phone, &mlp->phone[1], list) {
 			if (i++ == idev->dial) {
-				strncpy(pci.remote_num,phone->num,63);
+				strlcpy(pci.remote_num,phone->num,sizeof(pci.remote_num));
 				break;
 			}
 		}
Index: linux-2.5/drivers/isdn/eicon/eicon_idi.c
===================================================================
--- linux-2.5/drivers/isdn/eicon/eicon_idi.c	(revision 10182)
+++ linux-2.5/drivers/isdn/eicon/eicon_idi.c	(working copy)
@@ -1118,8 +1118,7 @@
 		//eicon_log(NULL, 128, "sT30:universal_7 = %x\n", t30->universal_7);
 		eicon_log(NULL, 128, "sT30:station_id_len = %x\n", t30->station_id_len);
 		eicon_log(NULL, 128, "sT30:head_line_len = %x\n", t30->head_line_len);
-		strncpy(st, t30->station_id, t30->station_id_len);
-		st[t30->station_id_len] = 0;
+		strlcpy(st, t30->station_id, t30->station_id_len + 1);
 		eicon_log(NULL, 128, "sT30:station_id = <%s>\n", st);
 	}
 	return(sizeof(eicon_t30_s));
@@ -1195,8 +1194,7 @@
 		//eicon_log(ccard, 128, "rT30:universal_7 = %x\n", p->universal_7);
 		eicon_log(ccard, 128, "rT30:station_id_len = %x\n", p->station_id_len);
 		eicon_log(ccard, 128, "rT30:head_line_len = %x\n", p->head_line_len);
-		strncpy(st, p->station_id, p->station_id_len);
-		st[p->station_id_len] = 0;
+		strlcpy(st, p->station_id, p->station_id_len + 1);
 		eicon_log(ccard, 128, "rT30:station_id = <%s>\n", st);
 	}
 	if (!chan->fax) {
Index: linux-2.5/drivers/isdn/eicon/eicon_mod.c
===================================================================
--- linux-2.5/drivers/isdn/eicon/eicon_mod.c	(revision 10182)
+++ linux-2.5/drivers/isdn/eicon/eicon_mod.c	(working copy)
@@ -848,7 +848,7 @@
 			ISDN_FEATURE_P_UNKNOWN;
 		card->interface.hl_hdrlen = 20;
 		card->ptype = ISDN_PTYPE_UNKNOWN;
-		strncpy(card->interface.id, id, sizeof(card->interface.id) - 1);
+		strlcpy(card->interface.id, id, sizeof(card->interface.id));
 		card->myid = -1;
 		card->type = Type;
 		switch (Type) {
Index: linux-2.5/drivers/isdn/hardware/avm/b1.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/avm/b1.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/avm/b1.c	(working copy)
@@ -433,9 +433,9 @@
 	     j++, i += cinfo->versionbuf[i] + 1)
 		cinfo->version[j] = &cinfo->versionbuf[i + 1];
 
-	strncpy(ctrl->serial, cinfo->version[VER_SERIAL], CAPI_SERIAL_LEN);
+	strlcpy(ctrl->serial, cinfo->version[VER_SERIAL], sizeof(ctrl->serial));
 	memcpy(&ctrl->profile, cinfo->version[VER_PROFILE],sizeof(capi_profile));
-	strncpy(ctrl->manu, "AVM GmbH", CAPI_MANUFACTURER_LEN);
+	strlcpy(ctrl->manu, "AVM GmbH", sizeof(ctrl->manu));
 	dversion = cinfo->version[VER_DRIVER];
 	ctrl->version.majorversion = 2;
 	ctrl->version.minorversion = 0;
@@ -785,8 +785,7 @@
 	char rev[32];
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
-		strncpy(rev, p + 2, sizeof(rev));
-		rev[sizeof(rev)-1] = 0;
+		strlcpy(rev, p + 2, sizeof(rev));
 		if ((p = strchr(rev, '$')) != 0 && p > rev)
 		   *(p-1) = 0;
 	} else
Index: linux-2.5/drivers/isdn/hardware/avm/b1dma.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/avm/b1dma.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/avm/b1dma.c	(working copy)
@@ -945,8 +945,7 @@
 	char rev[32];
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
-		strncpy(rev, p + 2, sizeof(rev));
-		rev[sizeof(rev)-1] = 0;
+		strlcpy(rev, p + 2, sizeof(rev));
 		if ((p = strchr(rev, '$')) != 0 && p > rev)
 		   *(p-1) = 0;
 	} else
Index: linux-2.5/drivers/isdn/hardware/avm/avm_cs.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/avm/avm_cs.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/avm/avm_cs.c	(working copy)
@@ -320,7 +320,7 @@
 
 	devname[0] = 0;
 	if( !first_tuple(handle, &tuple, &parse) && parse.version_1.ns > 1 ) {
-	    strncpy(devname,parse.version_1.str + parse.version_1.ofs[1], 
+	    strlcpy(devname,parse.version_1.str + parse.version_1.ofs[1], 
 			sizeof(devname));
 	}
 	/*
Index: linux-2.5/drivers/isdn/hardware/eicon/um_idi.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/eicon/um_idi.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/eicon/um_idi.c	(working copy)
@@ -66,8 +66,8 @@
 		sync_req.GetName.Req = 0;
 		sync_req.GetName.Rc = IDI_SYNC_REQ_GET_NAME;
 		(*(a->d.request)) ((ENTITY *) & sync_req);
-		strncpy(features->name, sync_req.GetName.name,
-			sizeof(features->name) - 1);
+		strlcpy(features->name, sync_req.GetName.name,
+			sizeof(features->name));
 
 		sync_req.GetSerial.Req = 0;
 		sync_req.GetSerial.Rc = IDI_SYNC_REQ_GET_SERIAL;
Index: linux-2.5/drivers/isdn/hardware/eicon/i4l_idi.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/eicon/i4l_idi.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/eicon/i4l_idi.c	(working copy)
@@ -1127,8 +1127,7 @@
 		//eicon_log(NULL, 128, "sT30:universal_7 = %x\n", t30->universal_7);
 		eicon_log(NULL, 128, "sT30:station_id_len = %x\n", t30->station_id_len);
 		eicon_log(NULL, 128, "sT30:head_line_len = %x\n", t30->head_line_len);
-		strncpy(st, t30->station_id, t30->station_id_len);
-		st[t30->station_id_len] = 0;
+		strlcpy(st, t30->station_id, t30->station_id_len + 1);
 		eicon_log(NULL, 128, "sT30:station_id = <%s>\n", st);
 	}
 	return(sizeof(eicon_t30_s));
@@ -1204,8 +1203,7 @@
 		//eicon_log(ccard, 128, "rT30:universal_7 = %x\n", p->universal_7);
 		eicon_log(ccard, 128, "rT30:station_id_len = %x\n", p->station_id_len);
 		eicon_log(ccard, 128, "rT30:head_line_len = %x\n", p->head_line_len);
-		strncpy(st, p->station_id, p->station_id_len);
-		st[p->station_id_len] = 0;
+		strlcpy(st, p->station_id, p->station_id_len + 1);
 		eicon_log(ccard, 128, "rT30:station_id = <%s>\n", st);
 	}
 	if (!chan->fax) {
Index: linux-2.5/drivers/isdn/hardware/eicon/divasfunc.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/eicon/divasfunc.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/eicon/divasfunc.c	(working copy)
@@ -77,16 +77,10 @@
 		d.features = IoAdapters[card - 1]->Properties.Features;
 		DBG_TRC(("DIDD register A(%d) channels=%d", card,
 			 d.channels))
-		    /* workaround for different Name in structure */
-		    strncpy(IoAdapters[card - 1]->Name,
-			    IoAdapters[card - 1]->Properties.Name, MIN(30,
-								       strlen
-								       (IoAdapters
-									[card
-									 -
-									 1]->
-									Properties.
-									Name)));
+		/* workaround for different Name in structure */
+		strlcpy(IoAdapters[card - 1]->Name,
+			IoAdapters[card - 1]->Properties.Name,
+			sizeof(IoAdapters[card - 1]->Name));
 		req.didd_remove_adapter.e.Req = 0;
 		req.didd_add_adapter.e.Rc = IDI_SYNC_REQ_DIDD_ADD_ADAPTER;
 		req.didd_add_adapter.info.descriptor = (void *) &d;
Index: linux-2.5/drivers/isdn/hardware/eicon/capifunc.c
===================================================================
--- linux-2.5/drivers/isdn/hardware/eicon/capifunc.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hardware/eicon/capifunc.c	(working copy)
@@ -512,7 +512,7 @@
 	sync_req.GetName.Req = 0;
 	sync_req.GetName.Rc = IDI_SYNC_REQ_GET_NAME;
 	card->d.request((ENTITY *) & sync_req);
-	strncpy(card->name, sync_req.GetName.name, sizeof(card->name));
+	strlcpy(card->name, sync_req.GetName.name, sizeof(card->name));
 	ctrl = &card->capi_ctrl;
 	strcpy(ctrl->name, card->name);
 	ctrl->register_appl = diva_register_appl;
@@ -528,7 +528,7 @@
 		return (0);
 	}
 	card->Id = find_free_id();
-	strncpy(ctrl->manu, M_COMPANY, CAPI_MANUFACTURER_LEN);
+	strlcpy(ctrl->manu, M_COMPANY, sizeof(ctrl->manu));
 	ctrl->version.majorversion = 2;
 	ctrl->version.minorversion = 0;
 	ctrl->version.majormanuversion = DRRELMAJOR;
@@ -544,7 +544,7 @@
 		sprintf(serial, "%ld", sync_req.GetSerial.serial);
 	}
 	serial[CAPI_SERIAL_LEN - 1] = 0;
-	strncpy(ctrl->serial, serial, CAPI_SERIAL_LEN);
+	strlcpy(ctrl->serial, serial, sizeof(ctrl->serial));
 
 	a = &adapter[card->Id - 1];
 	card->adapter = a;
Index: linux-2.5/drivers/isdn/act2000/module.c
===================================================================
--- linux-2.5/drivers/isdn/act2000/module.c	(revision 10182)
+++ linux-2.5/drivers/isdn/act2000/module.c	(working copy)
@@ -601,7 +601,7 @@
 		ISDN_FEATURE_P_UNKNOWN;
         card->interface.hl_hdrlen = 20;
         card->ptype = ISDN_PTYPE_EURO;
-        strncpy(card->interface.id, id, sizeof(card->interface.id) - 1);
+        strlcpy(card->interface.id, id, sizeof(card->interface.id));
         for (i=0; i<ACT2000_BCH; i++) {
                 card->bch[i].plci = 0x8000;
                 card->bch[i].ncci = 0x8000;
Index: linux-2.5/drivers/isdn/icn/icn.c
===================================================================
--- linux-2.5/drivers/isdn/icn/icn.c	(revision 10182)
+++ linux-2.5/drivers/isdn/icn/icn.c	(working copy)
@@ -509,7 +509,7 @@
 				char *s = strpbrk(t, ",");
 
 				*s++ = '\0';
-				strncpy(cmd.parm.setup.phone, t,
+				strlcpy(cmd.parm.setup.phone, t,
 					sizeof(cmd.parm.setup.phone));
 				s = strpbrk(t = s, ",");
 				*s++ = '\0';
@@ -525,7 +525,7 @@
 				else
 					cmd.parm.setup.si2 =
 					    simple_strtoul(t, NULL, 10);
-				strncpy(cmd.parm.setup.eazmsn, s,
+				strlcpy(cmd.parm.setup.eazmsn, s,
 					sizeof(cmd.parm.setup.eazmsn));
 			}
 			cmd.parm.setup.plan = 0;
@@ -540,19 +540,19 @@
 			cmd.parm.setup.screen = 0;
 			break;
 		case 5:
-			strncpy(cmd.parm.num, status + 3, sizeof(cmd.parm.num) - 1);
+			strlcpy(cmd.parm.num, status + 3, sizeof(cmd.parm.num));
 			break;
 		case 6:
-			sprintf(cmd.parm.num, "%d",
+			snprintf(cmd.parm.num, sizeof(cmd.parm.num), "%d",
 			     (int) simple_strtoul(status + 7, NULL, 16));
 			break;
 		case 7:
 			status += 3;
 			if (strlen(status) == 4)
-				sprintf(cmd.parm.num, "%s%c%c",
+				snprintf(cmd.parm.num, sizeof(cmd.parm.num), "%s%c%c",
 				     status + 2, *status, *(status + 1));
 			else
-				strncpy(cmd.parm.num, status + 1, sizeof(cmd.parm.num) - 1);
+				strlcpy(cmd.parm.num, status + 1, sizeof(cmd.parm.num));
 			break;
 		case 8:
 			card->flags &= ~ICN_FLAGS_B1ACTIVE;
@@ -1558,7 +1558,7 @@
 	    ISDN_FEATURE_L3_TRANS |
 	    ISDN_FEATURE_P_UNKNOWN;
 	card->ptype = ISDN_PTYPE_UNKNOWN;
-	strncpy(card->interface.id, id, sizeof(card->interface.id) - 1);
+	strlcpy(card->interface.id, id, sizeof(card->interface.id));
 	card->msg_buf_write = card->msg_buf;
 	card->msg_buf_read = card->msg_buf;
 	card->msg_buf_end = &card->msg_buf[sizeof(card->msg_buf) - 1];
Index: linux-2.5/drivers/isdn/capi/capifs.c
===================================================================
--- linux-2.5/drivers/isdn/capi/capifs.c	(revision 10182)
+++ linux-2.5/drivers/isdn/capi/capifs.c	(working copy)
@@ -234,8 +234,7 @@
 	int err;
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
-		strncpy(rev, p + 2, sizeof(rev));
-		rev[sizeof(rev)-1] = 0;
+		strlcpy(rev, p + 2, sizeof(rev));
 		if ((p = strchr(rev, '$')) != 0 && p > rev)
 		   *(p-1) = 0;
 	} else
Index: linux-2.5/drivers/isdn/capi/kcapi.c
===================================================================
--- linux-2.5/drivers/isdn/capi/kcapi.c	(revision 10182)
+++ linux-2.5/drivers/isdn/capi/kcapi.c	(working copy)
@@ -631,14 +631,14 @@
 	struct capi_ctr *card;
 
 	if (contr == 0) {
-		strncpy(buf, capi_manufakturer, CAPI_MANUFACTURER_LEN);
+		strlcpy(buf, capi_manufakturer, sizeof(buf));
 		return CAPI_NOERROR;
 	}
 	card = get_capi_ctr_by_nr(contr);
 	if (!card || card->cardstate != CARD_RUNNING) 
 		return CAPI_REGNOTINSTALLED;
 
-	strncpy(buf, card->manu, CAPI_MANUFACTURER_LEN);
+	strlcpy(buf, card->manu, sizeof(buf));
 	return CAPI_NOERROR;
 }
 
@@ -667,14 +667,14 @@
 	struct capi_ctr *card;
 
 	if (contr == 0) {
-		strncpy(serial, driver_serial, CAPI_SERIAL_LEN);
+		strlcpy(serial, driver_serial, sizeof(serial));
 		return CAPI_NOERROR;
 	}
 	card = get_capi_ctr_by_nr(contr);
 	if (!card || card->cardstate != CARD_RUNNING) 
 		return CAPI_REGNOTINSTALLED;
 
-	strncpy((void *) serial, card->serial, CAPI_SERIAL_LEN);
+	strlcpy((void *) serial, card->serial, sizeof(serial));
 	return CAPI_NOERROR;
 }
 
@@ -873,8 +873,7 @@
         kcapi_proc_init();
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
-		strncpy(rev, p + 2, sizeof(rev));
-		rev[sizeof(rev)-1] = 0;
+		strlcpy(rev, p + 2, sizeof(rev));
 		if ((p = strchr(rev, '$')) != 0 && p > rev)
 		   *(p-1) = 0;
 	} else
Index: linux-2.5/drivers/isdn/capi/capi.c
===================================================================
--- linux-2.5/drivers/isdn/capi/capi.c	(revision 10182)
+++ linux-2.5/drivers/isdn/capi/capi.c	(working copy)
@@ -1460,8 +1460,7 @@
 
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
-		strncpy(rev, p + 2, sizeof(rev));
-		rev[sizeof(rev)-1] = 0;
+		strlcpy(rev, p + 2, sizeof(rev));
 		if ((p = strchr(rev, '$')) != 0 && p > rev)
 		   *(p-1) = 0;
 	} else
Index: linux-2.5/drivers/isdn/hisax/avma1_cs.c
===================================================================
--- linux-2.5/drivers/isdn/hisax/avma1_cs.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hisax/avma1_cs.c	(working copy)
@@ -335,7 +335,7 @@
 
 	devname[0] = 0;
 	if( !first_tuple(handle, &tuple, &parse) && parse.version_1.ns > 1 ) {
-	    strncpy(devname,parse.version_1.str + parse.version_1.ofs[1], 
+	    strlcpy(devname,parse.version_1.str + parse.version_1.ofs[1], 
 			sizeof(devname));
 	}
 	/*
Index: linux-2.5/drivers/isdn/hisax/callc.c
===================================================================
--- linux-2.5/drivers/isdn/hisax/callc.c	(revision 10182)
+++ linux-2.5/drivers/isdn/hisax/callc.c	(working copy)
@@ -1478,11 +1478,11 @@
 		return;
 	switch(cm->para[3]) {
 		case 4: /* Suspend */
-			strncpy(chanp->setup.phone, &cm->para[5], cm->para[5] +1);
+			strlcpy(chanp->setup.phone, &cm->para[5], cm->para[5] +1);
 			FsmEvent(&chanp->fi, EV_SUSPEND, cm);
 			break;
 		case 5: /* Resume */
-			strncpy(chanp->setup.phone, &cm->para[5], cm->para[5] +1);
+			strlcpy(chanp->setup.phone, &cm->para[5], cm->para[5] +1);
 			if (chanp->fi.state == ST_NULL) {
 				FsmEvent(&chanp->fi, EV_RESUME, cm);
 			} else {
Index: linux-2.5/drivers/pnp/core.c
===================================================================
--- linux-2.5/drivers/pnp/core.c	(revision 10182)
+++ linux-2.5/drivers/pnp/core.c	(working copy)
@@ -69,7 +69,7 @@
 
 	protocol->number = nodenum;
 	sprintf(protocol->dev.bus_id, "pnp%d", nodenum);
-	strncpy(protocol->dev.name,protocol->name,DEVICE_NAME_SIZE);
+	strlcpy(protocol->dev.name,protocol->name,DEVICE_NAME_SIZE);
 	return device_register(&protocol->dev);
 }
 
Index: linux-2.5/drivers/s390/net/ctcmain.c
===================================================================
--- linux-2.5/drivers/s390/net/ctcmain.c	(revision 10182)
+++ linux-2.5/drivers/s390/net/ctcmain.c	(working copy)
@@ -2915,7 +2915,7 @@
 
 	ctc_add_attributes(&cgdev->dev);
 
-	strncpy(privptr->fsm->name, dev->name, sizeof (privptr->fsm->name));
+	strlcpy(privptr->fsm->name, dev->name, sizeof (privptr->fsm->name));
 
 	print_banner();
 
Index: linux-2.5/drivers/s390/net/fsm.c
===================================================================
--- linux-2.5/drivers/s390/net/fsm.c	(revision 10182)
+++ linux-2.5/drivers/s390/net/fsm.c	(working copy)
@@ -26,7 +26,7 @@
 		return NULL;
 	}
 	memset(this, 0, sizeof(fsm_instance));
-	strncpy(this->name, name, sizeof(this->name));
+	strlcpy(this->name, name, sizeof(this->name));
 
 	f = (fsm *)kmalloc(sizeof(fsm), order);
 	if (f == NULL) {
Index: linux-2.5/drivers/s390/net/cu3088.c
===================================================================
--- linux-2.5/drivers/s390/net/cu3088.c	(revision 10182)
+++ linux-2.5/drivers/s390/net/cu3088.c	(working copy)
@@ -80,8 +80,7 @@
 		if (!(end = strchr(start, delim[i])))
 			return count;
 		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start);
-		strncpy (bus_ids[i], start, len);
-		bus_ids[i][len] = '\0';
+		strlcpy (bus_ids[i], start, len);
 		argv[i] = bus_ids[i];
 		start = end + 1;
 	}
Index: linux-2.5/drivers/s390/cio/css.c
===================================================================
--- linux-2.5/drivers/s390/cio/css.c	(revision 10182)
+++ linux-2.5/drivers/s390/cio/css.c	(working copy)
@@ -97,7 +97,7 @@
 	sch->dev.bus = &css_bus_type;
 
 	/* Set a name for the subchannel */
-	strncpy (sch->dev.name, subchannel_types[sch->st], DEVICE_NAME_SIZE);
+	strlcpy (sch->dev.name, subchannel_types[sch->st], DEVICE_NAME_SIZE);
 	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0:%04x", sch->irq);
 
 	/* make it known to the system */
Index: linux-2.5/drivers/input/misc/uinput.c
===================================================================
--- linux-2.5/drivers/input/misc/uinput.c	(revision 10182)
+++ linux-2.5/drivers/input/misc/uinput.c	(working copy)
@@ -192,15 +192,14 @@
 	if (NULL != dev->name) 
 		kfree(dev->name);
 
-	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE);
-	dev->name = kmalloc(size + 1, GFP_KERNEL);
+	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
+	dev->name = kmalloc(size, GFP_KERNEL);
 	if (!dev->name) {
 		retval = -ENOMEM;
 		goto exit;
 	}
 
-	strncpy(dev->name, user_dev->name, size);
-	dev->name[size] = '\0';
+	strlcpy(dev->name, user_dev->name, size);
 	dev->id.bustype	= user_dev->id.bustype;
 	dev->id.vendor	= user_dev->id.vendor;
 	dev->id.product	= user_dev->id.product;
Index: linux-2.5/drivers/mca/mca-legacy.c
===================================================================
--- linux-2.5/drivers/mca/mca-legacy.c	(revision 10182)
+++ linux-2.5/drivers/mca/mca-legacy.c	(working copy)
@@ -278,8 +278,7 @@
 	if(!mca_dev)
 		return;
 
-	strncpy(mca_dev->dev.name, name, sizeof(mca_dev->dev.name));
-	mca_dev->dev.name[sizeof(mca_dev->dev.name) - 1] = '\0';
+	strlcpy(mca_dev->dev.name, name, sizeof(mca_dev->dev.name));
 }
 EXPORT_SYMBOL(mca_set_adapter_name);
 
Index: linux-2.5/drivers/video/pm2fb.c
===================================================================
--- linux-2.5/drivers/video/pm2fb.c	(revision 10182)
+++ linux-2.5/drivers/video/pm2fb.c	(working copy)
@@ -2307,9 +2307,7 @@
 }
 
 static void __init pm2fb_font_setup(char* options) {
-
-	strncpy(pm2fb_options.font, options, sizeof(pm2fb_options.font));
-	pm2fb_options.font[sizeof(pm2fb_options.font)-1]='\0';
+	strlcpy(pm2fb_options.font, options, sizeof(pm2fb_options.font));
 }
 
 static void __init pm2fb_var_setup(char* options) {
Index: linux-2.5/drivers/video/pm3fb.c
===================================================================
--- linux-2.5/drivers/video/pm3fb.c	(revision 10182)
+++ linux-2.5/drivers/video/pm3fb.c	(working copy)
@@ -2631,8 +2631,7 @@
 		DPRINTK(1, "Fontname %s too long\n", lf);
 		return;
 	}
-	strncpy(fontn[board_num], lf, lfs);
-	fontn[board_num][lfs] = '\0';
+	strlcpy(fontn[board_num], lf, lfs + 1);
 }
 
 static void pm3fb_bootdepth_setup(char *bds, unsigned long board_num)
Index: linux-2.5/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.5/drivers/video/aty/atyfb_base.c	(revision 10182)
+++ linux-2.5/drivers/video/aty/atyfb_base.c	(working copy)
@@ -2425,7 +2425,7 @@
 			 && (!strncmp(this_opt, "Mach64:", 7))) {
 			static unsigned char m64_num;
 			static char mach64_str[80];
-			strncpy(mach64_str, this_opt + 7, 80);
+			strlcpy(mach64_str, this_opt + 7, sizeof(mach64_str));
 			if (!store_video_par(mach64_str, m64_num)) {
 				m64_num++;
 				mach64_count = m64_num;
Index: linux-2.5/drivers/video/matrox/matroxfb_base.c
===================================================================
--- linux-2.5/drivers/video/matrox/matroxfb_base.c	(revision 10182)
+++ linux-2.5/drivers/video/matrox/matroxfb_base.c	(working copy)
@@ -2364,7 +2364,7 @@
 		else if (!strncmp(this_opt, "vesa:", 5))
 			vesa = simple_strtoul(this_opt+5, NULL, 0);
 		else if (!strncmp(this_opt, "font:", 5))
-			strncpy(fontname, this_opt+5, sizeof(fontname)-1);
+			strlcpy(fontname, this_opt+5, sizeof(fontname));
 		else if (!strncmp(this_opt, "maxclk:", 7))
 			maxclk = simple_strtoul(this_opt+7, NULL, 0);
 		else if (!strncmp(this_opt, "fh:", 3))
@@ -2374,7 +2374,7 @@
 		else if (!strncmp(this_opt, "mem:", 4))
 			mem = simple_strtoul(this_opt+4, NULL, 0);
 		else if (!strncmp(this_opt, "mode:", 5))
-			strncpy(videomode, this_opt+5, sizeof(videomode)-1);
+			strlcpy(videomode, this_opt+5, sizeof(videomode));
 		else if (!strncmp(this_opt, "dfp:", 4)) {
 			dfp_type = simple_strtoul(this_opt+4, NULL, 0);
 			dfp = 1;
@@ -2454,7 +2454,7 @@
 			else if (!strcmp(this_opt, "dfp"))
 				dfp = value;
 			else {
-				strncpy(videomode, this_opt, sizeof(videomode)-1);
+				strlcpy(videomode, this_opt, sizeof(videomode));
 			}
 		}
 	}
Index: linux-2.5/drivers/video/p9100.c
===================================================================
--- linux-2.5/drivers/video/p9100.c	(revision 10182)
+++ linux-2.5/drivers/video/p9100.c	(working copy)
@@ -250,8 +250,7 @@
 {
 	struct p9100_par *par = (struct p9100_par *)info->par;
 
-	strncpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
Index: linux-2.5/drivers/video/cg3.c
===================================================================
--- linux-2.5/drivers/video/cg3.c	(revision 10182)
+++ linux-2.5/drivers/video/cg3.c	(working copy)
@@ -253,8 +253,7 @@
 {
 	struct cg3_par *par = (struct cg3_par *)info->par;
 
-	strncpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
Index: linux-2.5/drivers/video/cirrusfb.c
===================================================================
--- linux-2.5/drivers/video/cirrusfb.c	(revision 10182)
+++ linux-2.5/drivers/video/cirrusfb.c	(working copy)
@@ -2777,9 +2777,8 @@
 	fb_info->gen.parsize = sizeof (struct clgenfb_par);
 	fb_info->gen.fbhw = &clgen_hwswitch;
 
-	strncpy (fb_info->gen.info.modename, clgen_board_info[btype].name,
+	strlcpy (fb_info->gen.info.modename, clgen_board_info[btype].name,
 		 sizeof (fb_info->gen.info.modename));
-	fb_info->gen.info.modename [sizeof (fb_info->gen.info.modename) - 1] = 0;
 
 	fb_info->gen.info.fbops = &clgenfb_ops;
 	fb_info->gen.info.disp = &disp;
Index: linux-2.5/drivers/video/leo.c
===================================================================
--- linux-2.5/drivers/video/leo.c	(revision 10182)
+++ linux-2.5/drivers/video/leo.c	(working copy)
@@ -336,8 +336,7 @@
 {
 	struct leo_par *par = (struct leo_par *)info->par;
 
-	strncpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_TRUECOLOR;
Index: linux-2.5/drivers/video/radeonfb.c
===================================================================
--- linux-2.5/drivers/video/radeonfb.c	(revision 10182)
+++ linux-2.5/drivers/video/radeonfb.c	(working copy)
@@ -2243,8 +2243,7 @@
         info->screen_base = (char *)rinfo->fb_base;
 
 	/* Fill fix common fields */
-	strncpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
-	info->fix.id[sizeof(info->fix.id) - 1] = '\0';
+	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
         info->fix.smem_start = rinfo->fb_base_phys;
         info->fix.smem_len = rinfo->video_ram;
         info->fix.type = FB_TYPE_PACKED_PIXELS;
Index: linux-2.5/drivers/video/ffb.c
===================================================================
--- linux-2.5/drivers/video/ffb.c	(revision 10182)
+++ linux-2.5/drivers/video/ffb.c	(working copy)
@@ -810,8 +810,7 @@
 	} else
 		ffb_type_name = "Elite 3D";
 
-	strncpy(info->fix.id, ffb_type_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, ffb_type_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_TRUECOLOR;
Index: linux-2.5/drivers/video/tcx.c
===================================================================
--- linux-2.5/drivers/video/tcx.c	(revision 10182)
+++ linux-2.5/drivers/video/tcx.c	(working copy)
@@ -290,8 +290,7 @@
 	else
 		tcx_name = "TCX24";
 
-	strncpy(info->fix.id, tcx_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, tcx_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
Index: linux-2.5/drivers/video/cg14.c
===================================================================
--- linux-2.5/drivers/video/cg14.c	(revision 10182)
+++ linux-2.5/drivers/video/cg14.c	(working copy)
@@ -337,8 +337,7 @@
 {
 	struct cg14_par *par = (struct cg14_par *)info->par;
 
-	strncpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_TRUECOLOR;
Index: linux-2.5/drivers/video/sstfb.c
===================================================================
--- linux-2.5/drivers/video/sstfb.c	(revision 10182)
+++ linux-2.5/drivers/video/sstfb.c	(working copy)
@@ -1462,7 +1462,7 @@
 		goto fail;
 	}
 	sst_get_memsize(info, &fix->smem_len);
-	strncpy(fix->id, spec->name, sizeof(fix->id));
+	strlcpy(fix->id, spec->name, sizeof(fix->id));
 
 	iprintk("%s (revision %d) with %s dac\n",
 		fix->id, par->revision, par->dac_sw.name);
Index: linux-2.5/drivers/video/cyber2000fb.c
===================================================================
--- linux-2.5/drivers/video/cyber2000fb.c	(revision 10182)
+++ linux-2.5/drivers/video/cyber2000fb.c	(working copy)
@@ -1128,7 +1128,7 @@
 		info->disable_extregs = cyber2000fb_disable_extregs;
 		info->info            = int_cfb_info;
 
-		strncpy(info->dev_name, int_cfb_info->fb.fix.id, sizeof(info->dev_name));
+		strlcpy(info->dev_name, int_cfb_info->fb.fix.id, sizeof(info->dev_name));
 	}
 
 	return int_cfb_info != NULL;
@@ -1319,7 +1319,7 @@
 			continue;
 
 		if (strncmp(opt, "font:", 5) == 0) {
-			strncpy(default_font_storage, opt + 5, sizeof(default_font_storage));
+			strlcpy(default_font_storage, opt + 5, sizeof(default_font_storage));
 			default_font = default_font_storage;
 			continue;
 		}
Index: linux-2.5/drivers/video/retz3fb.c
===================================================================
--- linux-2.5/drivers/video/retz3fb.c	(revision 10182)
+++ linux-2.5/drivers/video/retz3fb.c	(working copy)
@@ -1336,8 +1336,7 @@
 			z3fb_inverse = 1;
 			fb_invert_cmaps();
 		} else if (!strncmp(this_opt, "font:", 5)) {
-			strncpy(fontname, this_opt+5, 39);
-			fontname[39] = '\0';
+			strlcpy(fontname, this_opt+5, sizeof(fontname));
 		} else
 			z3fb_mode = get_video_mode(this_opt);
 	}
@@ -1410,7 +1409,7 @@
 		fb_info->switch_con = &z3fb_switch;
 		fb_info->updatevar = &z3fb_updatevar;
 		fb_info->flags = FBINFO_FLAG_DEFAULT;
-		strncpy(fb_info->fontname, fontname, 40);
+		strlcpy(fb_info->fontname, fontname, sizeof(fb_info->fontname));
 
 		if (z3fb_mode == -1)
 			retz3fb_default = retz3fb_predefined[0].var;
Index: linux-2.5/drivers/video/console/sticore.c
===================================================================
--- linux-2.5/drivers/video/console/sticore.c	(revision 10182)
+++ linux-2.5/drivers/video/console/sticore.c	(working copy)
@@ -273,7 +273,7 @@
 static int __init sti_setup(char *str)
 {
 	if (str)
-		strncpy (default_sti_path, str, sizeof (default_sti_path));
+		strlcpy (default_sti_path, str, sizeof (default_sti_path));
 	
 	return 0;
 }
Index: linux-2.5/drivers/video/tgafb.c
===================================================================
--- linux-2.5/drivers/video/tgafb.c	(revision 10182)
+++ linux-2.5/drivers/video/tgafb.c	(working copy)
@@ -1341,8 +1341,7 @@
 		break;
 	}
 
-	strncpy(info->fix.id, tga_type_name, sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, tga_type_name, sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.type_aux = 0;
Index: linux-2.5/drivers/video/bw2.c
===================================================================
--- linux-2.5/drivers/video/bw2.c	(revision 10182)
+++ linux-2.5/drivers/video/bw2.c	(working copy)
@@ -194,8 +194,7 @@
 static void
 bw2_init_fix(struct fb_info *info, int linebytes)
 {
-	strncpy(info->fix.id, "bwtwo", sizeof(info->fix.id) - 1);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	strlcpy(info->fix.id, "bwtwo", sizeof(info->fix.id));
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_MONO01;
Index: linux-2.5/drivers/pci/pool.c
===================================================================
--- linux-2.5/drivers/pci/pool.c	(revision 10182)
+++ linux-2.5/drivers/pci/pool.c	(working copy)
@@ -128,8 +128,7 @@
 	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
 		return retval;
 
-	strncpy (retval->name, name, sizeof retval->name);
-	retval->name [sizeof retval->name - 1] = 0;
+	strlcpy (retval->name, name, sizeof retval->name);
 
 	retval->dev = pdev;
 
Index: linux-2.5/drivers/char/i8k.c
===================================================================
--- linux-2.5/drivers/char/i8k.c	(revision 10182)
+++ linux-2.5/drivers/char/i8k.c	(working copy)
@@ -167,7 +167,7 @@
  */
 static int i8k_get_serial_number(unsigned char *buff)
 {
-    strncpy(buff, serial_number, 16);
+    strlcpy(buff, serial_number, sizeof(serial_number));
     return 0;
 }
 
@@ -551,24 +551,24 @@
     case  0:	/* BIOS Information */
 	p = dmi_string(dmi,data[5]);
 	if (*p) {
-	    strncpy(bios_version, p, sizeof(bios_version));
+	    strlcpy(bios_version, p, sizeof(bios_version));
 	    string_trim(bios_version, sizeof(bios_version));
 	}
 	break;	
     case 1:	/* System Information */
 	p = dmi_string(dmi,data[4]);
 	if (*p) {
-	    strncpy(system_vendor, p, sizeof(system_vendor));
+	    strlcpy(system_vendor, p, sizeof(system_vendor));
 	    string_trim(system_vendor, sizeof(system_vendor));
 	}
 	p = dmi_string(dmi,data[5]);
 	if (*p) {
-	    strncpy(product_name, p, sizeof(product_name));
+	    strlcpy(product_name, p, sizeof(product_name));
 	    string_trim(product_name, sizeof(product_name));
 	}
 	p = dmi_string(dmi,data[7]);
 	if (*p) {
-	    strncpy(serial_number, p, sizeof(serial_number));
+	    strlcpy(serial_number, p, sizeof(serial_number));
 	    string_trim(serial_number, sizeof(serial_number));
 	}
 	break;
Index: linux-2.5/drivers/char/ftape/zftape/zftape-vtbl.h
===================================================================
--- linux-2.5/drivers/char/ftape/zftape/zftape-vtbl.h	(revision 10182)
+++ linux-2.5/drivers/char/ftape/zftape/zftape-vtbl.h	(working copy)
@@ -129,8 +129,7 @@
 #define DUMP_VOLINFO(level, desc, info)					\
 {									\
 	char tmp[21];							\
-	strncpy(tmp, desc, 20);						\
-	tmp[20] = '\0';							\
+	strlcpy(tmp, desc, sizeof(tmp));				\
 	TRACE(level, "Volume %d:\n"					\
 	      KERN_INFO "description  : %s\n"				\
 	      KERN_INFO "first segment: %d\n"				\
Index: linux-2.5/drivers/char/rio/rioinit.c
===================================================================
--- linux-2.5/drivers/char/rio/rioinit.c	(revision 10182)
+++ linux-2.5/drivers/char/rio/rioinit.c	(working copy)
@@ -1541,8 +1541,10 @@
 struct rioVersion *
 RIOVersid(void)
 {
-    strncpy(stVersion.version, "RIO driver for linux V1.0", 255);
-    strncpy(stVersion.buildDate, __DATE__, 255);
+    strlcpy(stVersion.version, "RIO driver for linux V1.0",
+	    sizeof(stVersion.version));
+    strlcpy(stVersion.buildDate, __DATE__,
+	    sizeof(stVersion.buildDate));
 
     return &stVersion;
 }
Index: linux-2.5/drivers/eisa/eisa-bus.c
===================================================================
--- linux-2.5/drivers/eisa/eisa-bus.c	(revision 10182)
+++ linux-2.5/drivers/eisa/eisa-bus.c	(working copy)
@@ -38,9 +38,9 @@
 
 	for (i = 0; i < EISA_INFOS; i++) {
 		if (!strcmp (edev->id.sig, eisa_table[i].id.sig)) {
-			strncpy (edev->dev.name,
+			strlcpy (edev->dev.name,
 				 eisa_table[i].name,
-				 DEVICE_NAME_SIZE - 1);
+				 DEVICE_NAME_SIZE);
 			return;
 		}
 	}
Index: linux-2.5/drivers/parisc/led.c
===================================================================
--- linux-2.5/drivers/parisc/led.c	(revision 10182)
+++ linux-2.5/drivers/parisc/led.c	(working copy)
@@ -667,7 +667,7 @@
 	tasklet_disable(&led_tasklet);
 
 	/* copy display string to buffer for procfs */
-	strncpy(lcd_text, str, sizeof(lcd_text)-1);
+	strlcpy(lcd_text, str, sizeof(lcd_text));
 	
 	/* Set LCD Cursor to 1st character */
 	gsc_writeb(lcd_info.reset_cmd1, LCD_CMD_REG);
Index: linux-2.5/drivers/parisc/ccio-dma.c
===================================================================
--- linux-2.5/drivers/parisc/ccio-dma.c	(revision 10182)
+++ linux-2.5/drivers/parisc/ccio-dma.c	(working copy)
@@ -1522,7 +1522,7 @@
 	memset(ioc, 0, sizeof(struct ioc));
 
 	ioc->name = dev->id.hversion == U2_IOA_RUNWAY ? "U2" : "UTurn";
-	strncpy(dev->dev.name, ioc->name, sizeof(dev->dev.name));
+	strlcpy(dev->dev.name, ioc->name, sizeof(dev->dev.name));
 
 	printk(KERN_INFO "Found %s at 0x%lx\n", ioc->name, dev->hpa);
 
Index: linux-2.5/drivers/usb/net/kaweth.c
===================================================================
--- linux-2.5/drivers/usb/net/kaweth.c	(revision 10182)
+++ linux-2.5/drivers/usb/net/kaweth.c	(working copy)
@@ -670,7 +670,7 @@
 	switch (ethcmd) {
 	case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
-		strncpy(info.driver, "kaweth", sizeof(info.driver)-1);
+		strlcpy(info.driver, "kaweth", sizeof(info.driver));
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: linux-2.5/drivers/usb/net/pegasus.c
===================================================================
--- linux-2.5/drivers/usb/net/pegasus.c	(revision 10182)
+++ linux-2.5/drivers/usb/net/pegasus.c	(working copy)
@@ -927,10 +927,10 @@
 	/* get driver-specific version/etc. info */
 	case ETHTOOL_GDRVINFO:{
 			struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
-			strncpy(info.driver, driver_name,
-				sizeof (info.driver) - 1);
-			strncpy(info.version, DRIVER_VERSION,
-				sizeof (info.version) - 1);
+			strlcpy(info.driver, driver_name,
+				sizeof (info.driver));
+			strlcpy(info.version, DRIVER_VERSION,
+				sizeof (info.version));
 			if (copy_to_user(useraddr, &info, sizeof (info)))
 				return -EFAULT;
 			return 0;
Index: linux-2.5/drivers/usb/misc/brlvger.c
===================================================================
--- linux-2.5/drivers/usb/misc/brlvger.c	(revision 10182)
+++ linux-2.5/drivers/usb/misc/brlvger.c	(working copy)
@@ -708,12 +708,10 @@
 	case BRLVGER_GET_INFO: {
 		struct brlvger_info vi;
 
-		strncpy(vi.driver_version, DRIVER_VERSION,
+		strlcpy(vi.driver_version, DRIVER_VERSION,
 			sizeof(vi.driver_version));
-		vi.driver_version[sizeof(vi.driver_version)-1] = 0;
-		strncpy(vi.driver_banner, longbanner,
+		strlcpy(vi.driver_banner, longbanner,
 			sizeof(vi.driver_banner));
-		vi.driver_banner[sizeof(vi.driver_banner)-1] = 0;
 
 		vi.display_length = priv->plength;
 		
Index: linux-2.5/drivers/usb/gadget/zero.c
===================================================================
--- linux-2.5/drivers/usb/gadget/zero.c	(revision 10182)
+++ linux-2.5/drivers/usb/gadget/zero.c	(working copy)
@@ -1205,8 +1205,7 @@
 	/* a real value would likely come through some id prom
 	 * or module option.  this one takes at least two packets.
 	 */
-	strncpy (serial, "0123456789.0123456789.0123456789", sizeof serial);
-	serial [sizeof serial - 1] = 0;
+	strlcpy (serial, "0123456789.0123456789.0123456789", sizeof serial);
 
 	return usb_gadget_register_driver (&zero_driver);
 }
Index: linux-2.5/drivers/block/loop.c
===================================================================
--- linux-2.5/drivers/block/loop.c	(revision 10182)
+++ linux-2.5/drivers/block/loop.c	(working copy)
@@ -867,7 +867,7 @@
 	if (err)
 		return err;	
 
-	strncpy(lo->lo_name, info->lo_name, LO_NAME_SIZE);
+	strlcpy(lo->lo_name, info->lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
 	lo->ioctl = xfer_funcs[type]->ioctl;
@@ -902,7 +902,7 @@
 	info->lo_rdevice = lo->lo_device ? stat.rdev : stat.dev;
 	info->lo_offset = lo->lo_offset;
 	info->lo_flags = lo->lo_flags;
-	strncpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
+	strlcpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
 	info->lo_encrypt_type = lo->lo_encrypt_type;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
 		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
Index: linux-2.5/drivers/block/genhd.c
===================================================================
--- linux-2.5/drivers/block/genhd.c	(revision 10182)
+++ linux-2.5/drivers/block/genhd.c	(working copy)
@@ -89,8 +89,7 @@
 	}
 
 	p->major = major;
-	strncpy(p->name, name, sizeof(p->name)-1);
-	p->name[sizeof(p->name)-1] = 0;
+	strlcpy(p->name, name, sizeof(p->name));
 	p->next = 0;
 	index = major_to_index(major);
 
Index: linux-2.5/drivers/pcmcia/cs.c
===================================================================
--- linux-2.5/drivers/pcmcia/cs.c	(revision 10182)
+++ linux-2.5/drivers/pcmcia/cs.c	(working copy)
@@ -1026,7 +1026,7 @@
     if (!client) return CS_OUT_OF_RESOURCE;
     memset(client, '\0', sizeof(client_t));
     client->client_magic = CLIENT_MAGIC;
-    strncpy(client->dev_info, (char *)req->dev_info, DEV_NAME_LEN);
+    strlcpy(client->dev_info, (char *)req->dev_info, DEV_NAME_LEN);
     client->Socket = req->Socket;
     client->Function = req->Function;
     client->state = CLIENT_UNBOUND;
@@ -1069,7 +1069,7 @@
     }
     if (!region || (region->mtd != NULL))
 	return CS_BAD_OFFSET;
-    strncpy(region->dev_info, (char *)req->dev_info, DEV_NAME_LEN);
+    strlcpy(region->dev_info, (char *)req->dev_info, DEV_NAME_LEN);
     
     DEBUG(1, "cs: bind_mtd(): attr 0x%x, offset 0x%x, dev %s\n",
 	  req->Attributes, req->CardOffset, (char *)req->dev_info);
Index: linux-2.5/drivers/pcmcia/tcic.c
===================================================================
--- linux-2.5/drivers/pcmcia/tcic.c	(revision 10182)
+++ linux-2.5/drivers/pcmcia/tcic.c	(working copy)
@@ -527,7 +527,7 @@
     tcic_data.nsock = sockets;
     tcic_class_data.dev = &tcic_device.dev;
     tcic_class_data.class_data = &tcic_data;
-    strncpy(tcic_class_data.class_id, "tcic-pcmcia", BUS_ID_SIZE);
+    strlcpy(tcic_class_data.class_id, "tcic-pcmcia", BUS_ID_SIZE);
     
     platform_device_register(&tcic_device);
     class_device_register(&tcic_class_data);
Index: linux-2.5/drivers/pcmcia/i82365.c
===================================================================
--- linux-2.5/drivers/pcmcia/i82365.c	(revision 10182)
+++ linux-2.5/drivers/pcmcia/i82365.c	(working copy)
@@ -1560,7 +1560,7 @@
     i82365_data.nsock = sockets;
     i82365_class_data.dev = &i82365_device.dev;
     i82365_class_data.class_data = &i82365_data;
-    strncpy(i82365_class_data.class_id, "i82365", BUS_ID_SIZE);
+    strlcpy(i82365_class_data.class_id, "i82365", BUS_ID_SIZE);
     
     platform_device_register(&i82365_device);
     class_device_register(&i82365_class_data);
Index: linux-2.5/drivers/pcmcia/ds.c
===================================================================
--- linux-2.5/drivers/pcmcia/ds.c	(revision 10182)
+++ linux-2.5/drivers/pcmcia/ds.c	(working copy)
@@ -480,8 +480,7 @@
 			/* Try to handle "next" here some way? */
 		}
 		if (dev && dev->driver) {
-			strncpy(bind_info->name, dev->driver->name, DEV_NAME_LEN);
-			bind_info->name[DEV_NAME_LEN-1] = '\0';
+			strlcpy(bind_info->name, dev->driver->name, DEV_NAME_LEN);
 			bind_info->major = 0;
 			bind_info->minor = 0;
 			bind_info->next = NULL;
@@ -507,8 +506,7 @@
 	    if (node == bind_info->next) break;
     if (node == NULL) return -ENODEV;
 
-    strncpy(bind_info->name, node->dev_name, DEV_NAME_LEN);
-    bind_info->name[DEV_NAME_LEN-1] = '\0';
+    strlcpy(bind_info->name, node->dev_name, DEV_NAME_LEN);
     bind_info->major = node->major;
     bind_info->minor = node->minor;
     bind_info->next = node->next;
Index: linux-2.5/drivers/pcmcia/pci_socket.c
===================================================================
--- linux-2.5/drivers/pcmcia/pci_socket.c	(revision 10182)
+++ linux-2.5/drivers/pcmcia/pci_socket.c	(working copy)
@@ -155,7 +155,7 @@
 	socket->cls_d.ops = &pci_socket_operations;
 	socket->cls_d.class_dev.class = &pcmcia_socket_class;
 	socket->cls_d.class_dev.dev = &dev->dev;
-	strncpy(socket->cls_d.class_dev.class_id, dev->dev.bus_id, BUS_ID_SIZE);
+	strlcpy(socket->cls_d.class_dev.class_id, dev->dev.bus_id, BUS_ID_SIZE);
 	class_set_devdata(&socket->cls_d.class_dev, &socket->cls_d);
 
 	/* prepare pci_socket_t */
Index: linux-2.5/drivers/pcmcia/i82092.c
===================================================================
--- linux-2.5/drivers/pcmcia/i82092.c	(revision 10182)
+++ linux-2.5/drivers/pcmcia/i82092.c	(working copy)
@@ -178,7 +178,7 @@
 	pci_set_drvdata(dev, &cls_d);
 	cls_d->class_dev.class = &pcmcia_socket_class;
 	cls_d->class_dev.dev = &dev->dev;
-	strncpy(cls_d->class_dev.class_id, dev->dev.name, BUS_ID_SIZE);
+	strlcpy(cls_d->class_dev.class_id, dev->dev.name, BUS_ID_SIZE);
 	class_set_devdata(&cls_d->class_dev, cls_d);
 	class_device_register(&cls_d->class_dev);
 
Index: linux-2.5/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.5/drivers/md/dm-ioctl.c	(revision 10182)
+++ linux-2.5/drivers/md/dm-ioctl.c	(working copy)
@@ -488,9 +488,9 @@
 		 * Sneakily write in both the name and the uuid
 		 * while we have the cell.
 		 */
-		strncpy(param->name, hc->name, sizeof(param->name));
+		strlcpy(param->name, hc->name, sizeof(param->name));
 		if (hc->uuid)
-			strncpy(param->uuid, hc->uuid, sizeof(param->uuid) - 1);
+			strlcpy(param->uuid, hc->uuid, sizeof(param->uuid));
 		else
 			param->uuid[0] = '\0';
 
@@ -626,7 +626,7 @@
 		spec->status = 0;
 		spec->sector_start = ti->begin;
 		spec->length = ti->len;
-		strncpy(spec->target_type, ti->type->name,
+		strlcpy(spec->target_type, ti->type->name,
 			sizeof(spec->target_type));
 
 		outptr += sizeof(struct dm_target_spec);
Index: linux-2.5/drivers/scsi/osst.c
===================================================================
--- linux-2.5/drivers/scsi/osst.c	(revision 10182)
+++ linux-2.5/drivers/scsi/osst.c	(working copy)
@@ -2227,8 +2227,7 @@
 	}
 	if (strncmp(header->ident_str, "ADR_SEQ", 7) != 0 &&
 	    strncmp(header->ident_str, "ADR-SEQ", 7) != 0) {
-		strncpy(id_string, header->ident_str, 7);
-		id_string[7] = 0;
+		strlcpy(id_string, header->ident_str, 8);
 #if DEBUG
 		printk(OSST_DEB_MSG "%s:D: Invalid header identification string %s\n", name, id_string);
 #endif
Index: linux-2.5/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.5/drivers/scsi/sym53c8xx_2/sym_glue.c	(revision 10182)
+++ linux-2.5/drivers/scsi/sym53c8xx_2/sym_glue.c	(working copy)
@@ -1987,7 +1987,7 @@
 	/*
 	 *  Edit its name.
 	 */
-	strncpy(np->s.chip_name, dev->chip.name, sizeof(np->s.chip_name)-1);
+	strlcpy(np->s.chip_name, dev->chip.name, sizeof(np->s.chip_name));
 	sprintf(np->s.inst_name, "sym%d", np->s.unit);
 
 	/*
Index: linux-2.5/drivers/scsi/NCR_D700.c
===================================================================
--- linux-2.5/drivers/scsi/NCR_D700.c	(revision 10182)
+++ linux-2.5/drivers/scsi/NCR_D700.c	(working copy)
@@ -332,7 +332,7 @@
 	}
 
 	mca_device_set_claim(mca_dev, 1);
-	strncpy(dev->name, "NCR_D700", sizeof(dev->name));
+	strlcpy(dev->name, "NCR_D700", sizeof(dev->name));
 	dev_set_drvdata(dev, p);
 	return 0;
 }
Index: linux-2.5/drivers/scsi/in2000.c
===================================================================
--- linux-2.5/drivers/scsi/in2000.c	(revision 10182)
+++ linux-2.5/drivers/scsi/in2000.c	(working copy)
@@ -1820,8 +1820,7 @@
 	int i;
 	char *p1, *p2;
 
-	strncpy(setup_buffer, str, SETUP_BUFFER_SIZE);
-	setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
+	strlcpy(setup_buffer, str, SETUP_BUFFER_SIZE);
 	p1 = setup_buffer;
 	i = 0;
 	while (*p1 && (i < MAX_SETUP_ARGS)) {
Index: linux-2.5/drivers/scsi/sim710.c
===================================================================
--- linux-2.5/drivers/scsi/sim710.c	(revision 10182)
+++ linux-2.5/drivers/scsi/sim710.c	(working copy)
@@ -253,7 +253,7 @@
 	} else {
 		return -ENODEV;
 	}
-	strncpy(dev->name, name, sizeof(dev->name));
+	strlcpy(dev->name, name, sizeof(dev->name));
 	mca_device_set_claim(mca_dev, 1);
 	base = mca_device_transform_ioport(mca_dev, base);
 	irq_vector = mca_device_transform_irq(mca_dev, irq_vector);
Index: linux-2.5/drivers/scsi/aacraid/aachba.c
===================================================================
--- linux-2.5/drivers/scsi/aacraid/aachba.c	(revision 10182)
+++ linux-2.5/drivers/scsi/aacraid/aachba.c	(working copy)
@@ -1130,7 +1130,7 @@
 	else
 		qd.unmapped = 0;
 
-	strncpy(qd.name, fsa_dev_ptr->devname[qd.cnum], 8);
+	strlcpy(qd.name, fsa_dev_ptr->devname[qd.cnum], sizeof(qd.name));
 
 	if (copy_to_user(arg, &qd, sizeof (struct aac_query_disk)))
 		return -EFAULT;
Index: linux-2.5/drivers/scsi/gdth.c
===================================================================
--- linux-2.5/drivers/scsi/gdth.c	(revision 10182)
+++ linux-2.5/drivers/scsi/gdth.c	(working copy)
@@ -2295,15 +2295,15 @@
         TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD OK\n"));
         printk("GDT CTR%d Vendor: %s\n",hanum,oemstr->text.oem_company_name);
         /* Save the Host Drive inquiry data */
-        strncpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,7);
-        ha->oem_name[7] = '\0';
+        strlcpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,
+		sizeof(ha->oem_name));
     } else {
         /* Old method, based on PCI ID */
         TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD failed\n"));
         if (ha->oem_id == OEM_ID_INTEL)
-            strcpy(ha->oem_name,"Intel  ");
+            strlcpy(ha->oem_name,"Intel  ", sizeof(ha->oem_name));
         else
-            strcpy(ha->oem_name,"ICP    ");
+            strlcpy(ha->oem_name,"ICP    ", sizeof(ha->oem_name));
     }
 
     /* scanning for host drives */
Index: linux-2.5/drivers/scsi/ncr53c8xx.c
===================================================================
--- linux-2.5/drivers/scsi/ncr53c8xx.c	(revision 10182)
+++ linux-2.5/drivers/scsi/ncr53c8xx.c	(working copy)
@@ -3701,7 +3701,7 @@
 	/*
 	**	Store input informations in the host data structure.
 	*/
-	strncpy(np->chip_name, device->chip.name, sizeof(np->chip_name) - 1);
+	strlcpy(np->chip_name, device->chip.name, sizeof(np->chip_name));
 	np->unit	= unit;
 	np->verbose	= driver_setup.verbose;
 	sprintf(np->inst_name, "ncr53c%s-%d", np->chip_name, np->unit);
@@ -5033,7 +5033,7 @@
 	char inst_name[16];
 
 	/* Local copy so we don't access np after freeing it! */
-	strncpy(inst_name, ncr_name(np), 16);
+	strlcpy(inst_name, ncr_name(np), sizeof(inst_name));
 
 	printk("%s: releasing host resources\n", ncr_name(np));
 
Index: linux-2.5/drivers/scsi/eata_pio.c
===================================================================
--- linux-2.5/drivers/scsi/eata_pio.c	(revision 10182)
+++ linux-2.5/drivers/scsi/eata_pio.c	(working copy)
@@ -736,10 +736,8 @@
 	memset(hd->ccb, 0, (sizeof(struct eata_ccb) * ntohs(gc->queuesiz)));
 	memset(hd->reads, 0, sizeof(unsigned long) * 26);
 
-	strncpy(SD(sh)->vendor, &buff[8], 8);
-	SD(sh)->vendor[8] = 0;
-	strncpy(SD(sh)->name, &buff[16], 17);
-	SD(sh)->name[17] = 0;
+	strlcpy(SD(sh)->vendor, &buff[8], sizeof(SD(sh)->vendor));
+	strlcpy(SD(sh)->name, &buff[16], sizeof(SD(sh)->name));
 	SD(sh)->revision[0] = buff[32];
 	SD(sh)->revision[1] = buff[33];
 	SD(sh)->revision[2] = buff[34];
Index: linux-2.5/drivers/scsi/sym53c8xx.c
===================================================================
--- linux-2.5/drivers/scsi/sym53c8xx.c	(revision 10182)
+++ linux-2.5/drivers/scsi/sym53c8xx.c	(working copy)
@@ -5454,7 +5454,7 @@
 	/*
 	**	Store input informations in the host data structure.
 	*/
-	strncpy(np->chip_name, device->chip.name, sizeof(np->chip_name) - 1);
+	strlcpy(np->chip_name, device->chip.name, sizeof(np->chip_name));
 	np->unit	= unit;
 	np->verbose	= driver_setup.verbose;
 	sprintf(np->inst_name, NAME53C "%s-%d", np->chip_name, np->unit);
Index: linux-2.5/drivers/ide/ide.c
===================================================================
--- linux-2.5/drivers/ide/ide.c	(revision 10182)
+++ linux-2.5/drivers/ide/ide.c	(working copy)
@@ -1398,7 +1398,7 @@
 		goto abort;
 	if (DRIVER(drive)->cleanup(drive))
 		goto abort;
-	strncpy(drive->driver_req, driver, 9);
+	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
 	if (ata_attach(drive)) {
 		spin_lock(&drives_lock);
 		list_del_init(&drive->list);
@@ -1838,7 +1838,7 @@
 		hwif = &ide_hwifs[hw];
 		drive = &hwif->drives[unit];
 		if (strncmp(s + 4, "ide-", 4) == 0) {
-			strncpy(drive->driver_req, s + 4, 9);
+			strlcpy(drive->driver_req, s + 4, sizeof(drive->driver_req));
 			goto done;
 		}
 		/*
Index: linux-2.5/drivers/ide/ide-proc.c
===================================================================
--- linux-2.5/drivers/ide/ide-proc.c	(revision 10182)
+++ linux-2.5/drivers/ide/ide-proc.c	(working copy)
@@ -522,8 +522,7 @@
 			if (*p != ':')
 				goto parse_error;
 			len = IDE_MIN(p - start, MAX_LEN);
-			strncpy(name, start, IDE_MIN(len, MAX_LEN));
-			name[len] = 0;
+			strlcpy(name, start, IDE_MIN(len, MAX_LEN));
 
 			if (n > 0) {
 				--n;
Index: linux-2.5/drivers/ide/ide-probe.c
===================================================================
--- linux-2.5/drivers/ide/ide-probe.c	(revision 10182)
+++ linux-2.5/drivers/ide/ide-probe.c	(working copy)
@@ -693,7 +693,7 @@
 	u32 i = 0;
 
 	/* register with global device tree */
-	strncpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
+	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
 	hwif->gendev.driver_data = hwif;
 	if (hwif->pci_dev)
Index: linux-2.5/drivers/acpi/scan.c
===================================================================
--- linux-2.5/drivers/acpi/scan.c	(revision 10182)
+++ linux-2.5/drivers/acpi/scan.c	(working copy)
@@ -66,7 +66,7 @@
 	spin_unlock(&acpi_device_lock);
 
 	kobject_init(&device->kobj);
-	strncpy(device->kobj.name,device->pnp.bus_id,KOBJ_NAME_LEN);
+	strlcpy(device->kobj.name,device->pnp.bus_id,KOBJ_NAME_LEN);
 	if (parent)
 		device->kobj.parent = &parent->kobj;
 	device->kobj.ktype = &ktype_acpi_ns;
Index: linux-2.5/drivers/acpi/toshiba_acpi.c
===================================================================
--- linux-2.5/drivers/acpi/toshiba_acpi.c	(revision 10182)
+++ linux-2.5/drivers/acpi/toshiba_acpi.c	(working copy)
@@ -108,8 +108,7 @@
 	int result;
 	char* str2 = kmalloc(n + 1, GFP_KERNEL);
 	if (str2 == 0) return 0;
-	strncpy(str2, str, n);
-	str2[n] = 0;
+	strlcpy(str2, str, n);
 	va_start(args, format);
 	result = vsscanf(str2, format, args);
 	va_end(args);
Index: linux-2.5/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.5/drivers/i2c/i2c-core.c	(revision 10182)
+++ linux-2.5/drivers/i2c/i2c-core.c	(working copy)
@@ -105,7 +105,7 @@
 	memset(&adap->class_dev, 0x00, sizeof(struct class_device));
 	adap->class_dev.dev = &adap->dev;
 	adap->class_dev.class = &i2c_adapter_class;
-	strncpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
+	strlcpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
 	class_device_register(&adap->class_dev);
 
 	/* inform drivers of new adapters */
Index: linux-2.5/drivers/i2c/chips/lm75.c
===================================================================
--- linux-2.5/drivers/i2c/chips/lm75.c	(revision 10182)
+++ linux-2.5/drivers/i2c/chips/lm75.c	(working copy)
@@ -194,7 +194,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
Index: linux-2.5/drivers/i2c/chips/adm1021.c
===================================================================
--- linux-2.5/drivers/i2c/chips/adm1021.c	(revision 10182)
+++ linux-2.5/drivers/i2c/chips/adm1021.c	(working copy)
@@ -310,7 +310,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
Index: linux-2.5/drivers/i2c/chips/w83781d.c
===================================================================
--- linux-2.5/drivers/i2c/chips/w83781d.c	(revision 10182)
+++ linux-2.5/drivers/i2c/chips/w83781d.c	(working copy)
@@ -1198,7 +1198,7 @@
 		request_region(address, W83781D_EXTENT, type_name);
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;
@@ -1271,7 +1271,7 @@
 			data->lm75[i].adapter = adapter;
 			data->lm75[i].driver = &w83781d_driver;
 			data->lm75[i].flags = 0;
-			strncpy(data->lm75[i].dev.name, client_name,
+			strlcpy(data->lm75[i].dev.name, client_name,
 				DEVICE_NAME_SIZE);
 			if (kind == w83783s)
 				break;
Index: linux-2.5/drivers/i2c/chips/it87.c
===================================================================
--- linux-2.5/drivers/i2c/chips/it87.c	(revision 10182)
+++ linux-2.5/drivers/i2c/chips/it87.c	(working copy)
@@ -692,7 +692,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
 
 	data->type = kind;
 
