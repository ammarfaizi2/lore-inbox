Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTA1Hg2>; Tue, 28 Jan 2003 02:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTA1Hg2>; Tue, 28 Jan 2003 02:36:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267331AbTA1HgU>;
	Tue, 28 Jan 2003 02:36:20 -0500
Date: Mon, 27 Jan 2003 23:39:12 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Yichen Xie <yxie@cs.stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>, <greg@kroah.com>,
       <vojtech@suse.cz>, <kai.germaschewski@gmx.de>
Subject: Re: [CHECKER] 87 potential array bounds error/buffer overruns in
 2.5.53
In-Reply-To: <000001c2c5a4$5c4465d0$09830c80@stanfordja31z2>
Message-ID: <Pine.LNX.4.33L2.0301272328210.28277-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 26 Jan 2003, Yichen Xie wrote:

| Attached are 87 potential buffer overruns in 2.5.53. Most arise from
| improper bounds checks, and some might be security holes where the array
| index comes from an untrusted source (e.g. copy_from_user). In the bug
| report, "len" refers to the length of the array or buffer being
| accessed, and "off" refers to the offset/index that is being used to
| access it. (off >= len) corresponds to a buffer overrun, while (off < 0)
| signals an underrun.
|
| As always, confirmations and comments will be appreciated.
| ############################################################

This stuff is just too good to be ignored.  Hopefully someone else
is also looking at it.

I've gone thru most of these (the ones that I could read :) and have
generated 37 patches that I will post after some sleep.  Here are
some comments on the ones that I'm _not_ patching.
My comments being with '#'.

Thanks,
-- 
~Randy



---------------------------------------------------------
# Comment in struct says that its size there is a placeholder........
[BUG] cmd array has size 2 (might be false positive, if cmd is used as a
buffer)
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:205:i2cmdUnixFlags:
ERROR:BUFFER:205:205:Array bounds error (off >= len) ((*pCM).cmd[2], len
= 2, off = 2, min(off-len) = 0)
i2cmdUnixFlags(unsigned short iflag,unsigned short cflag,unsigned short
lflag)
{
	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct47;

	pCM->cmd[1] = (unsigned char)  iflag;

Error --->
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;
---------------------------------------------------------
# Yes, looks wrong.
[BUG]
/home/yxie/linux-2.5.53/drivers/message/fusion/mptbase.c:4939:procmpt_cr
eate: ERROR:BUFFER:4939:4939:Array bounds error (off >= len)
(mpt_ioc_proc_list[ii], len = 2, off = 2, min(off-len) = 0)
				}
				ent->read_proc =
mpt_ioc_proc_list[ii].f;
				ent->data      = ioc;
			}
		} else {

Error --->
			printk(MYIOC_s_WARN_FMT "Could not create
/proc/mpt/%s subdir entry!\n",
					ioc->name,
mpt_ioc_proc_list[ii].name);
		}
		ioc = mpt_adapter_find_next(ioc);
---------------------------------------------------------
# Yes, looks wrong.
[BUG] need one more element in ZeroAddr
/home/yxie/linux-2.5.53/drivers/net/sk98lin/skxmac2.c:424:SkXmClrSrcChec
k: ERROR:BUFFER:424:424:Array bounds error (off >= len) (*pByte + 6, len
= 6, off = 6, min(off-len) = 0)
SK_IOC	IoC,	/* IO context */
int		Port)	/* The XMAC to handle with belongs to this Port
(MAC_1 + n) */
{
	SK_U16	ZeroAddr[3] = {0x0000, 0x0000, 0x0000};


Error --->
	XM_OUTHASH(IoC, Port, XM_SRC_CHK, &ZeroAddr);
}	/* SkXmClrSrcCheck */
---------------------------------------------------------
# This one is OK.  _devfs_append_entry() sets <old>.
[BUG] "old" might get garbage on the stack
/home/yxie/linux-2.5.53/fs/devfs/base.c:1179:_devfs_make_parent_for_leaf
: ERROR:BUFFER:1179:1179:Dereferencing uninitialized pointer (*old)
evaluated in the following state
	    de = _devfs_alloc_entry (name, next_pos, MODE_DIR);
	    devfs_get (de);
	    if ( !de || _devfs_append_entry (dir, de, FALSE, &old) )
	    {
		devfs_put (de);

Error --->
		if ( !old || !S_ISDIR (old->mode) )
		{
		    devfs_put (old);
		    devfs_put (dir);
---------------------------------------------------------
# Greg:  Looks like all [count] in that loop should be [i]....
[BUG]
/home/yxie/linux-2.5.53/drivers/hotplug/ibmphp_pci.c:1630:ibmphp_unconfi
gure_card: ERROR:BUFFER:1630:1630:Array bounds error (off >= len)
((*cur_func).mem[count], len = 6, off = 6, min(off-len) = 0)
					debug ("io[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->io[count]);
					cur_func->io[count] = NULL;
				}

Error --->
				if (cur_func->mem[count]) {
					debug ("mem[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->mem[count]);
---------------------------------------------------------
# Greg:  Looks like all [count] in that loop should be [i]....
[BUG] i or count?
/home/yxie/linux-2.5.53/drivers/hotplug/ibmphp_pci.c:1624:ibmphp_unconfi
gure_card: ERROR:BUFFER:1624:1624:Array bounds error (off >= len)
((*cur_func).io[count], len = 6, off = 6, min(off-len) = 0)
			} else {
				count = 6;
			}

			for (i = 0; i < count; i++) {

Error --->
				if (cur_func->io[count]) {
					debug ("io[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->io[count]);
---------------------------------------------------------
# Vojtech:  looks wrong.
[BUG]
/home/yxie/linux-2.5.53/drivers/input/keyboard/sunkbd.c:271:sunkbd_conne
ct: ERROR:BUFFER:271:271:Array bounds error (off >= len) [RANGE]
((*sunkbd).keycode[i], len = 128, off = sym_44382539, max(off-len) =
126)

	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);

	memcpy(sunkbd->keycode, sunkbd_keycode,
sizeof(sunkbd->keycode));
	for (i = 0; i < 255; i++)

Error --->
		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
	clear_bit(0, sunkbd->dev.keybit);

	sprintf(sunkbd->name, "%s/input", serio->phys);
---------------------------------------------------------
# I'm guessing that this is what the SCSI command requests....
[BUG] length of vendorId is 8
/home/yxie/linux-2.5.53/drivers/scsi/psi240i.c:334:Irq_Handler:
ERROR:BUFFER:334:334:Array bounds error (off >= len)
((*pinquiryData).VendorId[z], len = 8, off = 8, min(off-len) = 0)
				pinquiryData->AdditionalLength = 35 - 4;

				// Fill in vendor identification fields.
				for ( z = 0;  z < 20;  z += 2 )
					{

Error --->
					pinquiryData->VendorId[z]
= ((UCHAR *)identifyData.ModelNumber)[z + 1];
					pinquiryData->VendorId[z + 1] =
((UCHAR *)identifyData.ModelNumber)[z];
					}

---------------------------------------------------------
# Comment in struct says that its size there is a placeholder........
[BUG]
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:207:i2cmdUnixFlags:
ERROR:BUFFER:207:207:Array bounds error (off >= len) ((*pCM).cmd[4], len
= 2, off = 4, min(off-len) = 2)
	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct47;

	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;

Error --->
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
	return pCM;
---------------------------------------------------------
# I don't see the problem....
[BUG] missing comma in definition of split_status_strings
/home/yxie/linux-2.5.53/drivers/scsi/aic7xxx/aic79xx_pci.c:808:ahd_pci_s
plit_intr: ERROR:BUFFER:808:808:Array bounds error (off >= len) [RANGE]
(split_status_strings[bit], len = 7, off = sym_42005934, max(off-len) =
0)
		for (bit = 0; bit < 8; bit++) {

			if ((split_status[i] & (0x1 << bit)) != 0) {
				static const char *s;


Error --->
				s = split_status_strings[bit];
				printf(s, ahd_name(ahd),
				       split_status_source[i]);
			}
---------------------------------------------------------
# Comment in struct says that its size there is a placeholder........
[BUG] suspicious
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:261:i2cmdBaudDef:
ERROR:BUFFER:261:261:Array bounds error (off >= len) ((*pCM).cmd[2], len
= 2, off = 2, min(off-len) = 0)
	case 2:
		pCM = (cmdSyntaxPtr) ct55;
		break;
	}
	pCM->cmd[1] = (unsigned char) rate;

Error --->
	pCM->cmd[2] = (unsigned char) (rate >> 8);
	return pCM;
}

---------------------------------------------------------
# Needs work but not panic.
[BUG] should panic after printk
/home/yxie/linux-2.5.53/drivers/scsi/qlogicfc.c:926:isp2x00_make_portdb:
ERROR:BUFFER:926:926:Array bounds error (off >= len)
((*hostdata).port_db[j], len = 256, off = 256, min(off-len) = 0)
					break;
				}
			}
			if (j == QLOGICFC_MAX_ID + 1)
				printk("qlogicfc%d : Too many scsi
devices, no more room in port map.\n", hostdata->host_id);

Error --->
			if (!hostdata->port_db[j].wwn) {
				hostdata->port_db[j].loop_id =
temp[i].loop_id;
				hostdata->port_db[j].wwn = temp[i].wwn;
			}
---------------------------------------------------------
# Already changed/modified/different in 2.5.59.
[BUG]
/home/yxie/linux-2.5.53/arch/i386/kernel/cpu/cpufreq/powernow-k6.c:202:p
owernow_k6_setpolicy: ERROR:BUFFER:202:202:Array bounds error (off >=
len) (clock_ratio[i], len = 8, off = 8, min(off-len) = 0)
		break;
	default:
		return -EINVAL;
	}


Error --->
	if (clock_ratio[i] > max_multiplier)
		return -EINVAL;

	powernow_k6_set_state(j);
---------------------------------------------------------
# Comment in struct says that its size there is a placeholder........
[BUG] suspicious, since sizeof cmd is 2 (not 0 or 1, which is commonly
used for buffers)
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:209:i2cmdUnixFlags:
ERROR:BUFFER:209:209:Array bounds error (off >= len) ((*pCM).cmd[6], len
= 2, off = 6, min(off-len) = 4)
	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;

Error --->
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
	return pCM;
}

---------------------------------------------------------
# I'm guessing that this is what the SCSI command requests....
[BUG] length of VendorId is only 8
/home/yxie/linux-2.5.53/drivers/scsi/psi240i.c:335:Irq_Handler:
ERROR:BUFFER:335:335:Array bounds error (off >= len)
((*pinquiryData).VendorId[z + 1], len = 8, off = 9, min(off-len) = 1)

				// Fill in vendor identification fields.
				for ( z = 0;  z < 20;  z += 2 )
					{
					pinquiryData->VendorId[z]
= ((UCHAR *)identifyData.ModelNumber)[z + 1];

Error --->
					pinquiryData->VendorId[z + 1] =
((UCHAR *)identifyData.ModelNumber)[z];
					}

				// Initialize unused portion of product
id.
---------------------------------------------------------
# Don't see a problem here....
[BUG] missing comma in rq_flags
/home/yxie/linux-2.5.53/drivers/block/ll_rw_blk.c:685:blk_dump_rq_flags:
ERROR:BUFFER:685:685:Array bounds error (off >= len) (rq_flags[bit], len
= 17, off = 17, min(off-len) = 0)
	printk("%s: dev %s: flags = ", msg,
		rq->rq_disk ? rq->rq_disk->disk_name : "?");
	bit = 0;
	do {
		if (rq->flags & (1 << bit))

Error --->
			printk("%s ", rq_flags[bit]);
		bit++;
	} while (bit < __REQ_NR_BITS);

---------------------------------------------------------
# Comment in struct says that its size there is a placeholder........
[BUG] suspicious, but probably not bug
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:206:i2cmdUnixFlags:
ERROR:BUFFER:206:206:Array bounds error (off >= len) ((*pCM).cmd[3], len
= 2, off = 3, min(off-len) = 1)
{
	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct47;

	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);

Error --->
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
---------------------------------------------------------
# But if unit is 0 and becomes -1, that shouldn't be executed??
I.e., I think this code is OK; it's just confusing.
[BUG]
/home/yxie/linux-2.5.53/drivers/ide/ide-probe.c:1055:alloc_disks:
ERROR:BUFFER:1055:1055:Array bounds error (off < 0) [RANGE]
(disks[unit], min(off) = -1)
	}
	return 0;
Enomem:
	printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
	while (unit--)

Error --->
		put_disk(disks[unit]);
	return -ENOMEM;
}

---------------------------------------------------------
# Kai:  OR s/bar/i/ on 2 lines ??
[BUG] bar == 4? (from the loop above)
/home/yxie/linux-2.5.53/drivers/isdn/hardware/eicon/os_4bri.c:268:diva_4
bri_init_card: ERROR:BUFFER:268:268:Array bounds error (off >= len)
((*a).slave_adapters[bar], len = 3, off = (sym_17752159, 1, 1, 1),
min(off-len) = 1)
	 */
	quadro_list =
	    (PADAPTER_LIST_ENTRY) diva_os_malloc(0,
sizeof(*quadro_list));
	if (!(a->slave_list = quadro_list)) {
		for (i = 0; i < (tasks - 1); i++) {

Error --->
			diva_os_free(0, a->slave_adapters[bar]);
			a->slave_adapters[bar] = 0;
		}
		diva_4bri_cleanup_adapter(a);
---------------------------------------------------------
# Yes, problem.
[BUG] base = &buf[4]
/home/yxie/linux-2.5.53/drivers/cdrom/cdrom.c:1170:dvd_read_physical:
ERROR:BUFFER:1170:1170:Array bounds error (off >= len) (*base + 16, len
= 20, off = 20, min(off-len) = 0)
	layer->track_density = base[3] & 0xf;
	layer->linear_density = base[3] >> 4;
	layer->start_sector = base[5] << 16 | base[6] << 8 | base[7];
	layer->end_sector = base[9] << 16 | base[10] << 8 | base[11];
	layer->end_sector_l0 = base[13] << 16 | base[14] << 8 |
base[15];

Error --->
	layer->bca = base[16] >> 7;

	return 0;
}
---------------------------------------------------------
# Yes, problem.
[BUG]
/home/yxie/linux-2.5.53/fs/cifs/cifssmb.c:233:CIFSSMBLogoff:
ERROR:BUFFER:233:233:Dereferencing uninitialized pointer (*pSMB)
evaluated in the following state
	if (atomic_read(&ses->inUse) > 0) {
		up(&ses->sesSem);
		return -EBUSY;
	}
    if(ses->secMode & (SECMODE_SIGN_REQUIRED | SECMODE_SIGN_ENABLED))

Error --->
        pSMB->hdr.Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
	rc = smb_init(SMB_COM_LOGOFF_ANDX, 2, 0 /* no tcon anymore */ ,
		      (void **) &pSMB, (void **) &smb_buffer_response);
	if (rc) {
---------------------------------------------------------
# Maybe....
[BUG] check default branch above
/home/yxie/linux-2.5.53/drivers/video/sis/sis_main.c:398:sisfb_validate_
mode: ERROR:BUFFER:398:398:Array bounds error (off < 0)
(sisbios_mode[sisfb_mode_idx], max(off) = -1)
		}
		break;
	}

	if(ivideo.chip < SIS_315H) {

Error --->
             if(sisbios_mode[sisfb_mode_idx].xres > 1920)
	         sisfb_mode_idx = -1;
	}
	/* TW: TODO: Validate modes available on either 300 or 310/325
series only */
---------------------------------------------------------
# Yes, problem....
[BUG] minor (recommend inserting break in the true branch of the if
statement)
/home/yxie/linux-2.5.53/drivers/video/sis/init301.c:2053:SiS_SetCRT2FIFO
_310: ERROR:BUFFER:2053:2053:Array bounds error (off >= len) [RANGE]
(CombCode[(int)temp3 + 1], len = 16, off = (sym_11686423, 1, 3, 1),
max(off-len) = 0)
  /* get DRAM latency */
  tempcl = (SiS_GetReg1(SiS_P3c4,0x17) >> 3) & 0x7;     /* SR17[5:3]
DRAM Queue depth */
  tempch = (SiS_GetReg1(SiS_P3c4,0x17) >> 6) & 0x3;     /* SR17[7:6]
DRAM Grant length */

  for (temp3 = 0; temp3 < 16; temp3 += 2) {

Error --->
    if ((CombCode[temp3] == tempcl) && (CombCode[temp3+1] == tempch)) {
      temp3 = CRT2ThLow[temp3 >> 1];
    }
  }
---------------------------------------------------------
# Yes, looks wrong.
[BUG]
/home/yxie/linux-2.5.53/drivers/net/sk98lin/skxmac2.c:424:SkXmClrSrcChec
k: ERROR:BUFFER:424:424:Array bounds error (off >= len) (*pByte + 7, len
= 6, off = 7, min(off-len) = 1)
SK_IOC	IoC,	/* IO context */
int		Port)	/* The XMAC to handle with belongs to this Port
(MAC_1 + n) */
{
	SK_U16	ZeroAddr[3] = {0x0000, 0x0000, 0x0000};


Error --->
	XM_OUTHASH(IoC, Port, XM_SRC_CHK, &ZeroAddr);
}	/* SkXmClrSrcCheck */


---------------------------------------------------------
# Summary for
#  buffer-specific errors       = 87
#  /dev/null-specific errors = 0
#  Common errors 		      	  = 0
#  Total 				  = 87
-

