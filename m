Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263829AbTCUWAr>; Fri, 21 Mar 2003 17:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263883AbTCUV7v>; Fri, 21 Mar 2003 16:59:51 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:27524 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263829AbTCUV52>; Fri, 21 Mar 2003 16:57:28 -0500
Date: Fri, 21 Mar 2003 14:08:22 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: [CHECKER] potential dereference of user pointer errors
In-Reply-To: <20030321134449.A646@figure1.int.wirex.com>
Message-ID: <Pine.GSO.4.44.0303211359080.12835-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is a resend. I've made the error logs prettier.

Here is a summary of where the bugs occur.

	fs/block_dev.c
	drivers/usb/image/mdc800.c
	drivers/message/i2o/i2o_config.c
	drivers/net/wan/cosa.c
	drivers/sound/pci/es1938.c
	drivers/sound/oss/awe_wave.c
	drivers/usb/media/vicam.c
	drivers/usb/serial/kobil_sct.c
	drivers/video/sis/sis_main.c

As usual, any response will be greatly appreciated.

Question: 1. can the proc_dir_entry.write_proc take tainted inputs?
	  2. do all the _ioctl functions take tainted inputs?

------------------------------------------------------------------------
[UNKNOWN] sys_quotaoctl is a system call. It called lookup_bdev on the
param @special. But this file is under subdir fs. So there must be
something we are missing

/home/junfeng/linux-2.5.63/fs/block_dev.c:817:lookup_bdev:
ERROR:TAINTED:817:817:deferencing "path" tainted by [dist=1][called by
/home/junfeng/linux-2.5.63/fs/quota.c:sys_quotactl:parm1]

	struct block_device *bdev;
	struct inode *inode;
	struct nameidata nd;
	int error;


Error --->
	if (!path || !*path)
		return ERR_PTR(-EINVAL);

	error = path_lookup(path, LOOKUP_FOLLOW, &nd);
---------------------------------------------------------
[BUG] the write function can take tainted inputs. In the same sub dir,
scanner.c::write_scanner does copy_from_user

/home/junfeng/linux-2.5.63/drivers/usb/image/mdc800.c:794:mdc800_device_write:
ERROR:TAINTED:794:794:deferencing "buf" tainted by [dist=1][thru
file_operations:write
/home/junfeng/linux-2.5.63/sound/oss/es1370.c:es1370_write parm1  calling
copy_from_user:parm1]

			up (&mdc800->io_lock);
			return -EINTR;
		}

		/* check for command start */

Error --->
		if (buf [i] == (char) 0x55)
		{
			mdc800->in_count=0;
			mdc800->out_count=0;
---------------------------------------------------------
[BUG] copy_from_user (_, cmd, _) then copy_to_user (cmd->resbuf, _, _)

/home/junfeng/linux-2.5.63/drivers/message/i2o/i2o_config.c:440:ioctl_parms:
ERROR:TAINTED:408:440:deferencing "cmd" tainted by [dist=0][(null)]


	u32 i2o_cmd = (type == I2OPARMGET ?
				I2O_CMD_UTIL_PARAMS_GET :
				I2O_CMD_UTIL_PARAMS_SET);

Start --->
	if(copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_psetget)))

	... DELETED 43 lines ...

	}

	put_user(len, kcmd.reslen);
	if(len > reslen)
		ret = -ENOBUFS;
Error --->
	else if(copy_to_user(cmd->resbuf, res, len))
		ret = -EFAULT;

	kfree(res);
---------------------------------------------------------
[BUG] cosa_readmem and cosa_getidstr are both called by cosa_ioctl_common

/home/junfeng/linux-2.5.63/drivers/net/wan/cosa.c:1109:cosa_readmem:
ERROR:TAINTED:1152:1109:deferencing "d" tainted by [dist=2][called by
cosa_ioctl_common:parm3 calling cosa_getidstr:parm1 calling
copy_to_user:parm0]

		return -EFAULT;

	/* If something fails, force the user to reset the card */
	cosa->firmware_status &= ~COSA_FW_RESET;

Error --->
	if ((i=readmem(cosa, d->code, len, addr)) < 0) {

	... DELETED 37 lines ...


/* Buffer of size at least COSA_MAX_ID_STRING is expected */
static inline int cosa_getidstr(struct cosa_data *cosa, char *string)
{
	int l = strlen(cosa->id_string)+1;
Start --->
	if (copy_to_user(string, cosa->id_string, l))
		return -EFAULT;
	return l;
}
---------------------------------------------------------
[BUG] snd_cmipci_ac3_copy does copy_from_user, but snd_es1938_capture_copy
doesn't

/home/junfeng/linux-2.5.63/sound/pci/es1938.c:833:snd_es1938_capture_copy:
ERROR:TAINTED:993:833:passing "dst" into deref cal __constant_memcpy
[dist=1][thru snd_pcm_ops_t:copy
/home/junfeng/linux-2.5.63/sound/pci/cmipci.c:snd_cmipci_ac3_copy:parm3
copy_from_user:parm1]

	es1938_t *chip = snd_pcm_substream_chip(substream);
	pos <<= chip->dma1_shift;
	count <<= chip->dma1_shift;
	snd_assert(pos + count <= chip->dma1_size, return -EINVAL);
	if (pos + count < chip->dma1_size)
Error --->
		memcpy(dst, runtime->dma_area + pos + 1, count);

	... DELETED 154 lines ...

	.hw_params =	snd_es1938_pcm_hw_params,
	.hw_free =	snd_es1938_pcm_hw_free,
	.prepare =	snd_es1938_capture_prepare,
	.trigger =	snd_es1938_capture_trigger,
	.pointer =	snd_es1938_capture_pointer,
Start --->
	.copy =		snd_es1938_capture_copy,
};

static void snd_es1938_free_pcm(snd_pcm_t *pcm)
---------------------------------------------------------
[BUG] matroxfb_dh_ioctl does copy_from_user but sisfb_ioctl doesn't

/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c:1817:sis_malloc:
ERROR:TAINTED:2572:1817:deferencing "req" tainted by [dist=2][ called by
sisfb_ioctl:parm3 thru fb_ops:fb_ioctl
/home/junfeng/linux-2.5.63/drivers/video/matrox/matroxfb_crtc2.c:matroxfb_dh_ioctl:parm3
copy_to_user:parm0]


void sis_malloc(struct sis_memreq *req)
{
	SIS_OH *poh;

Error --->
	poh = sisfb_poh_allocate(req->size);

	... DELETED 749 lines ...

	.fb_set_cmap	= sisfb_set_cmap,
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,23)
        .fb_setcolreg	= sisfb_setcolreg,
        .fb_blank	= sisfb_blank,
#endif
Start --->
	.fb_ioctl	= sisfb_ioctl,
	.fb_mmap	= sisfb_mmap,
};

similar things

/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c:1817:sis_malloc:
ERROR:TAINTED deferencing "req" tainted by [dist=2][ called by
sisfb_ioctl:parm3 thru fb_ops:fb_ioctl
/home/junfeng/linux-2.5.63/drivers/video/matrox/matroxfb_crtc2.c:matroxfb_dh_ioctl:parm3
copy_to_user:parm0]

/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c:259:sis_get_glyph:
ERROR:TAINTED deferencing "gly" tainted by [dist=2][ called by
sisfb_ioctl:parm3 thru fb_ops:fb_ioctl
/home/junfeng/linux-2.5.63/drivers/video/matrox/matroxfb_crtc2.c:matroxfb_dh_ioctl:parm3
copy_to_user:parm0]

/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c:276:sis_dispinfo:
ERROR:TAINTED deferencing "rec" tainted by [dist=2][ called by
sisfb_ioctl:parm3 thru fb_ops:fb_ioctl
/home/junfeng/linux-2.5.63/drivers/video/matrox/matroxfb_crtc2.c:matroxfb_dh_ioctl:parm3
copy_to_user:parm0]


---------------------------------------------------------
[BUG] guswave_ioctl does copy_to_user but awe_ioctl doesn't, for the same
case branch "case SNDCTL_SYNTH_INFO"

/home/junfeng/linux-2.5.63/sound/oss/awe_wave.c:2049:awe_ioctl:
ERROR:TAINTED:504:2049: passing "arg" into deref cal __constant_memcpy
[dist=1][thru synth_operations:ioctl
/home/junfeng/linux-2.5.63/sound/oss/gus_wave.c:guswave_ioctl:parm2
copy_to_user:parm0]

	midi_dev:	0,
	synth_type:	SYNTH_TYPE_SAMPLE,
	synth_subtype:	SAMPLE_TYPE_AWE32,
	open:		awe_open,
	close:		awe_close,
Start --->
	ioctl:		awe_ioctl,

	... DELETED 1539 lines ...

	case SNDCTL_SYNTH_INFO:
		if (playing_mode == AWE_PLAY_DIRECT)
			awe_info.nr_voices = awe_max_voices;
		else
			awe_info.nr_voices = AWE_MAX_CHANNELS;
Error --->
		memcpy((char*)arg, &awe_info, sizeof(awe_info));
		return 0;
		break;

---------------------------------------------------------
[BUG] Bug is in vicam_write_proc_gain. cpia_write_proc does copy_from_user
while vicam_write_proc_gain doesn't.

/home/junfeng/linux-2.5.63/lib/vsprintf.c:64:simple_strtol:
ERROR:TAINTED:64:64:deferencing "cp" tainted by [dist=3][ calling
simple_strtoul  called by
/home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:vicam_write_proc_gain:parm1
thru proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc:parm1
copy_from_user:parm1]

 * @endp: A pointer to the end of the parsed string will be placed here
 * @base: The number base to use
 */
long simple_strtol(const char *cp,char **endp,unsigned int base)
{

Error --->
	if(*cp=='-')
		return -simple_strtoul(cp+1,endp,base);
	return simple_strtoul(cp,endp,base);
}
---------------------------------------------------------
[MINOR] in debugging code

/home/junfeng/linux-2.5.63/drivers/usb/serial/kobil_sct.c:429:kobil_write:
ERROR:TAINTED:437:429:deferencing "buf" tainted by
[dist=0][copy_from_user:parm1]

	if (! data) {
		return (-1);
	}
	memset(data, 0, (3 * count + 10));
	for (i = 0; i < count; i++) {
Error --->
		sprintf(data +3*i, "%02X ", buf[i]);
	}
	dbg(" %d --> %s", port->number, data );
	kfree(data);
	// END DEBUG

	// Copy data to buffer
	if (from_user) {
Start --->
		if (copy_from_user(priv->buf + priv->filled, buf, count))
{
			return -EFAULT;
		}
	} else {


