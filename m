Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264012AbTCXAOX>; Sun, 23 Mar 2003 19:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264014AbTCXAOX>; Sun, 23 Mar 2003 19:14:23 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:56459 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264012AbTCXANv>; Sun, 23 Mar 2003 19:13:51 -0500
Date: Sun, 23 Mar 2003 16:24:52 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: [CHECKER] 63 potential calling blocking functions with locks held
 errors
In-Reply-To: <Pine.GSO.4.44.0303231506070.21702-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0303231622570.25008-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enclosed are 63 potential calling blocking functions with lock held
errors. 37 of them appeared in sound/oss/maestro3.c. Any confirmation or
clarification will be greatly appreciated.

Junfeng

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1772:m3_ioctl:
ERROR:BLOCK:1771:1772:calling blocking fn m3_update_ptr with lock
&(*card).lock held [m3_update_ptr calling stop_dac calling
dec_timer_users calling __m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1771]

    case SNDCTL_DSP_GETOSPACE:
        if (!(file->f_mode & FMODE_WRITE))
            return -EINVAL;
        if (!(s->enable & DAC_RUNNING) && (val = prog_dmabuf(s, 0)) !=
0)
            return val;
Start --->
        spin_lock_irqsave(&card->lock, flags);
Error --->
        m3_update_ptr(s);
        abinfo.fragsize = s->dma_dac.fragsize;
        abinfo.bytes = s->dma_dac.dmasize - s->dma_dac.count;
        abinfo.fragstotal = s->dma_dac.numfrag;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:2773:ess_ioctl:
ERROR:BLOCK:2772:2773:calling blocking fn ess_update_ptr with lock
&(*s).lock held [ess_update_ptr calling get_dmaa calling
apu_get_register calling check_suspend calling schedule][START:
&(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, ess_ioctl, 2772]

        case SNDCTL_DSP_GETOPTR:
		if (!(file->f_mode & FMODE_WRITE))
			return -EINVAL;
		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
			return ret;
Start --->
		spin_lock_irqsave(&s->lock, flags);
Error --->
		ess_update_ptr(s);
                cinfo.bytes = s->dma_dac.total_bytes;
                cinfo.blocks = s->dma_dac.count >> s->dma_dac.fragshift;
                cinfo.ptr = s->dma_dac.hwptr;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1826:m3_ioctl:
ERROR:BLOCK:1825:1826:calling blocking fn m3_update_ptr with lock
&(*card).lock held [m3_update_ptr calling stop_dac calling
dec_timer_users calling __m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1825]

	return 0;

    case SNDCTL_DSP_GETOPTR:
        if (!(file->f_mode & FMODE_WRITE))
            return -EINVAL;
Start --->
        spin_lock_irqsave(&card->lock, flags);
Error --->
        m3_update_ptr(s);
        cinfo.bytes = s->dma_dac.total_bytes;
        cinfo.blocks = s->dma_dac.count >> s->dma_dac.fragshift;
        cinfo.ptr = s->dma_dac.hwptr;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1511:m3_poll:
ERROR:BLOCK:1510:1511:calling blocking fn m3_update_ptr with lock
&(*(*s).card).lock held [m3_update_ptr calling stop_dac calling
dec_timer_users calling __m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*(*s).card).lock,
unknown->locked, /home/junfeng/linux-2.5.63/sound/oss/maestro3.c,
m3_poll, 1510]

    if (file->f_mode & FMODE_WRITE)
        poll_wait(file, &s->dma_dac.wait, wait);
    if (file->f_mode & FMODE_READ)
        poll_wait(file, &s->dma_adc.wait, wait);

Start --->
    spin_lock_irqsave(&s->card->lock, flags);
Error --->
    m3_update_ptr(s);

    if (file->f_mode & FMODE_READ) {
        if (s->dma_adc.count >= (signed)s->dma_adc.fragsize)
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:2756:ess_ioctl:
ERROR:BLOCK:2755:2756:calling blocking fn ess_update_ptr with lock
&(*s).lock held [ess_update_ptr calling get_dmaa calling
apu_get_register calling check_suspend calling schedule][START:
&(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, ess_ioctl, 2755]

        case SNDCTL_DSP_GETIPTR:
		if (!(file->f_mode & FMODE_READ))
			return -EINVAL;
		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
			return ret;
Start --->
		spin_lock_irqsave(&s->lock, flags);
Error --->
		ess_update_ptr(s);
                cinfo.bytes = s->dma_adc.total_bytes;
                cinfo.blocks = s->dma_adc.count >> s->dma_adc.fragshift;
                cinfo.ptr = s->dma_adc.hwptr;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:2745:ess_ioctl:
ERROR:BLOCK:2744:2745:calling blocking fn ess_update_ptr with lock
&(*s).lock held [ess_update_ptr calling get_dmaa calling
apu_get_register calling check_suspend calling schedule][START:
&(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, ess_ioctl, 2744]

        case SNDCTL_DSP_GETODELAY:
		if (!(file->f_mode & FMODE_WRITE))
			return -EINVAL;
		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
			return ret;
Start --->
		spin_lock_irqsave(&s->lock, flags);
Error --->
		ess_update_ptr(s);
                val = s->dma_dac.count;
		spin_unlock_irqrestore(&s->lock, flags);
		return put_user(val, (int *)arg);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:430:m3_assp_read:
ERROR:BLOCK:429:430:calling blocking fn __m3_assp_read with lock
&(*card).lock held [__m3_assp_read calling m3_outw calling check_suspend
calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_assp_read, 429]

static u16 m3_assp_read(struct m3_card *card, u16 region, u16 index)
{
    unsigned long flags;
    u16 ret;

Start --->
    spin_lock_irqsave(&(card->lock), flags);
Error --->
    ret = __m3_assp_read(card, region, index);
    spin_unlock_irqrestore(&(card->lock), flags);

    return ret;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/atm/iphase.c:3221:ia_init_one:
ERROR:BLOCK:3220:3221:calling blocking fn ia_start with lock
&(*iadev).misc_lock held [ia_start calling rx_init calling
kmalloc][START: &(*iadev).misc_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/atm/iphase.c, ia_init_one, 3220]

	ia_dev[iadev_count] = iadev;
	_ia_dev[iadev_count] = dev;
	iadev_count++;
	spin_lock_init(&iadev->misc_lock);
	/* First fixes first. I don't want to think about this now. */
Start --->
	spin_lock_irqsave(&iadev->misc_lock, flags);
Error --->
	if (ia_init(dev) || ia_start(dev)) {
		IF_INIT(printk("IA register failed!\n");)
		iadev_count--;
		ia_dev[iadev_count] = NULL;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:449:m3_assp_write:
ERROR:BLOCK:448:449:calling blocking fn __m3_assp_write with lock
&(*card).lock held [__m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_assp_write, 448]

static void m3_assp_write(struct m3_card *card,
        u16 region, u16 index, u16 data)
{
    unsigned long flags;

Start --->
    spin_lock_irqsave(&(card->lock), flags);
Error --->
    __m3_assp_write(card, region, index, data);
    spin_unlock_irqrestore(&(card->lock), flags);
}

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:2727:ess_ioctl:
ERROR:BLOCK:2726:2727:calling blocking fn ess_update_ptr with lock
&(*s).lock held [ess_update_ptr calling get_dmaa calling
apu_get_register calling check_suspend calling schedule][START:
&(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, ess_ioctl, 2726]

	case SNDCTL_DSP_GETISPACE:
		if (!(file->f_mode & FMODE_READ))
			return -EINVAL;
		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
			return ret;
Start --->
		spin_lock_irqsave(&s->lock, flags);
Error --->
		ess_update_ptr(s);
		abinfo.fragsize = s->dma_adc.fragsize;
                abinfo.bytes = s->dma_adc.count;
                abinfo.fragstotal = s->dma_adc.numfrag;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:2468:ess_poll:
ERROR:BLOCK:2467:2468:calling blocking fn ess_update_ptr with lock
&(*s).lock held [ess_update_ptr calling get_dmaa calling
apu_get_register calling check_suspend calling schedule][START:
&(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, ess_poll, 2467]


	if (file->f_mode & FMODE_WRITE)
		poll_wait(file, &s->dma_dac.wait, wait);
	if (file->f_mode & FMODE_READ)
		poll_wait(file, &s->dma_adc.wait, wait);
Start --->
	spin_lock_irqsave(&s->lock, flags);
Error --->
	ess_update_ptr(s);
	if (file->f_mode & FMODE_READ) {
		if (s->dma_adc.count >= (signed)s->dma_adc.fragsize)
			mask |= POLLIN | POLLRDNORM;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1786:m3_ioctl:
ERROR:BLOCK:1785:1786:calling blocking fn m3_update_ptr with lock
&(*card).lock held [m3_update_ptr calling stop_dac calling
dec_timer_users calling __m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1785]

    case SNDCTL_DSP_GETISPACE:
        if (!(file->f_mode & FMODE_READ))
            return -EINVAL;
        if (!(s->enable & ADC_RUNNING) && (val = prog_dmabuf(s, 1)) !=
0)
            return val;
Start --->
        spin_lock_irqsave(&card->lock, flags);
Error --->
        m3_update_ptr(s);
        abinfo.fragsize = s->dma_adc.fragsize;
        abinfo.bytes = s->dma_adc.count;
        abinfo.fragstotal = s->dma_adc.numfrag;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1802:m3_ioctl:
ERROR:BLOCK:1801:1802:calling blocking fn m3_update_ptr with lock
&(*card).lock held [m3_update_ptr calling stop_dac calling
dec_timer_users calling __m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1801]

        return 0;

    case SNDCTL_DSP_GETODELAY:
        if (!(file->f_mode & FMODE_WRITE))
            return -EINVAL;
Start --->
        spin_lock_irqsave(&card->lock, flags);
Error --->
        m3_update_ptr(s);
        val = s->dma_dac.count;
        spin_unlock_irqrestore(&card->lock, flags);
        return put_user(val, (int *)arg);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:2713:ess_ioctl:
ERROR:BLOCK:2712:2713:calling blocking fn ess_update_ptr with lock
&(*s).lock held [ess_update_ptr calling get_dmaa calling
apu_get_register calling check_suspend calling schedule][START:
&(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, ess_ioctl, 2712]

	case SNDCTL_DSP_GETOSPACE:
		if (!(file->f_mode & FMODE_WRITE))
			return -EINVAL;
		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
			return ret;
Start --->
		spin_lock_irqsave(&s->lock, flags);
Error --->
		ess_update_ptr(s);
		abinfo.fragsize = s->dma_dac.fragsize;
                abinfo.bytes = s->dma_dac.dmasize - s->dma_dac.count;
                abinfo.fragstotal = s->dma_dac.numfrag;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1811:m3_ioctl:
ERROR:BLOCK:1810:1811:calling blocking fn m3_update_ptr with lock
&(*card).lock held [m3_update_ptr calling stop_dac calling
dec_timer_users calling __m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1810]

        return put_user(val, (int *)arg);

    case SNDCTL_DSP_GETIPTR:
        if (!(file->f_mode & FMODE_READ))
            return -EINVAL;
Start --->
        spin_lock_irqsave(&card->lock, flags);
Error --->
        m3_update_ptr(s);
        cinfo.bytes = s->dma_adc.total_bytes;
        cinfo.blocks = s->dma_adc.count >> s->dma_adc.fragshift;
        cinfo.ptr = s->dma_adc.hwptr;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1617:m3_ioctl:
ERROR:BLOCK:1615:1617:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1615]


    case SNDCTL_DSP_GETCAPS:
        return put_user(DSP_CAP_DUPLEX | DSP_CAP_REALTIME |
DSP_CAP_TRIGGER | DSP_CAP_MMAP, (int *)arg);

    case SNDCTL_DSP_RESET:
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (file->f_mode & FMODE_WRITE) {
Error --->
            stop_dac(s);
            synchronize_irq(s->card->pcidev->irq);
            s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count =
s->dma_dac.total_bytes = 0;
        }
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/ieee1394/sbp2.c:684:sbp2util_create_command_orb_pool:
ERROR:BLOCK:682:684:calling blocking fn kmalloc with lock
&(*scsi_id).sbp2_command_orb_lock held [kmalloc][START:
&(*scsi_id).sbp2_command_orb_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/ieee1394/sbp2.c,
sbp2util_create_command_orb_pool, 682]

	unsigned long flags, orbs;
	struct sbp2_command_info *command;

	orbs = sbp2_serialize_io ? 2 : SBP2_MAX_COMMAND_ORBS;

Start --->
	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
	for (i = 0; i < orbs; i++) {
Error --->
		command = (struct sbp2_command_info *)
		    kmalloc(sizeof(struct sbp2_command_info),
GFP_KERNEL);
		if (!command) {

spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c:1274:snd_korg1212_capture_open:
ERROR:BLOCK:1272:1274:calling blocking fn snd_korg1212_OpenCard with
lock &(*korg1212).lock held [snd_korg1212_OpenCard calling
snd_korg1212_setCardState calling snd_korg1212_TurnOffIdleMonitor
calling snd_korg1212_WaitForCardStopAck calling schedule][START:
&(*korg1212).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c,
snd_korg1212_capture_open, 1272]


#if K1212_DEBUG_LEVEL > 0
		K1212_DEBUG_PRINTK("K1212_DEBUG:
snd_korg1212_capture_open [%s]\n", stateName[korg1212->cardState]);
#endif

Start --->
        spin_lock_irqsave(&korg1212->lock, flags);

Error --->
        snd_korg1212_OpenCard(korg1212);

        snd_pcm_set_sync(substream);    // ???

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c:1244:snd_korg1212_playback_open:
ERROR:BLOCK:1242:1244:calling blocking fn snd_korg1212_OpenCard with
lock &(*korg1212).lock held [snd_korg1212_OpenCard calling
snd_korg1212_setCardState calling snd_korg1212_TurnOffIdleMonitor
calling snd_korg1212_WaitForCardStopAck calling schedule][START:
&(*korg1212).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c,
snd_korg1212_playback_open, 1242]


#if K1212_DEBUG_LEVEL > 0
		K1212_DEBUG_PRINTK("K1212_DEBUG:
snd_korg1212_playback_open [%s]\n", stateName[korg1212->cardState]);
#endif

Start --->
        spin_lock_irqsave(&korg1212->lock, flags);

Error --->
        snd_korg1212_OpenCard(korg1212);

        snd_pcm_set_sync(substream);    // ???

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/fs/jffs2/nodemgmt.c:111:jffs2_reserve_space_gc:
ERROR:BLOCK:109:111:calling blocking fn jffs2_do_reserve_space with lock
&(*c).erase_completion_lock held [jffs2_do_reserve_space calling
schedule][START: &(*c).erase_completion_lock, unknown->locked,
/home/junfeng/linux-2.5.63/fs/jffs2/nodemgmt.c, jffs2_reserve_space_gc,
109]

	int ret = -EAGAIN;
	minsize = PAD(minsize);

	D1(printk(KERN_DEBUG "jffs2_reserve_space_gc(): Requested 0x%x
bytes\n", minsize));

Start --->
	spin_lock_bh(&c->erase_completion_lock);
	while(ret == -EAGAIN) {
Error --->
		ret = jffs2_do_reserve_space(c, minsize, ofs, len);
		if (ret) {
		        D1(printk(KERN_DEBUG "jffs2_reserve_space_gc:
looping, ret is %d\n", ret));
		}
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c:1408:snd_korg1212_prepare:
ERROR:BLOCK:1406:1408:calling blocking fn snd_korg1212_SetupForPlay with
lock &(*korg1212).lock held [snd_korg1212_SetupForPlay calling
snd_korg1212_setCardState calling snd_korg1212_TurnOffIdleMonitor
calling snd_korg1212_WaitForCardStopAck calling schedule][START:
&(*korg1212).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c,
snd_korg1212_prepare, 1406]


#if K1212_DEBUG_LEVEL > 0
		K1212_DEBUG_PRINTK("K1212_DEBUG: snd_korg1212_prepare
[%s]\n", stateName[korg1212->cardState]);
#endif

Start --->
        spin_lock_irqsave(&korg1212->lock, flags);

Error --->
        snd_korg1212_SetupForPlay(korg1212);

        korg1212->currentBuffer = -1;

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:1751:prog_dmabuf:
ERROR:BLOCK:1748:1751:calling blocking fn stop_adc with lock &(*s).lock
held [stop_adc calling apu_set_register calling check_suspend calling
schedule][START: &(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, prog_dmabuf, 1748]

	unsigned bytepersec;
	unsigned bufs;
	unsigned char fmt;
	unsigned long flags;

Start --->
	spin_lock_irqsave(&s->lock, flags);
	fmt = s->fmt;
	if (rec) {
Error --->
		stop_adc(s);
		fmt >>= ESS_ADC_SHIFT;
	} else {
		stop_dac(s);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2072:m3_release:
ERROR:BLOCK:2069:2072:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_release, 2069]

    VALIDATE_STATE(s);
    if (file->f_mode & FMODE_WRITE)
        drain_dac(s, file->f_flags & O_NONBLOCK);

    down(&s->open_sem);
Start --->
    spin_lock_irqsave(&card->lock, flags);

    if (file->f_mode & FMODE_WRITE) {
Error --->
        stop_dac(s);
        if(s->dma_dac.in_lists) {
            m3_remove_list(s->card, &(s->card->mixer_list),
s->dma_dac.mixer_index);
            nuke_lists(s->card, &(s->dma_dac));
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1634:m3_ioctl:
ERROR:BLOCK:1631:1634:calling blocking fn stop_adc with lock
&(*card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1631]

        spin_unlock_irqrestore(&card->lock, flags);
        return 0;

    case SNDCTL_DSP_SPEED:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (val >= 0) {
            if (file->f_mode & FMODE_READ) {
Error --->
                stop_adc(s);
                s->dma_adc.ready = 0;
                set_adc_rate(s, val);
            }
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1653:m3_ioctl:
ERROR:BLOCK:1649:1653:calling blocking fn stop_adc with lock
&(*card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1649]

        spin_unlock_irqrestore(&card->lock, flags);
        return put_user((file->f_mode & FMODE_READ) ? s->rateadc :
s->ratedac, (int *)arg);

    case SNDCTL_DSP_STEREO:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        fmtd = 0;
        fmtm = ~0;
        if (file->f_mode & FMODE_READ) {
Error --->
            stop_adc(s);
            s->dma_adc.ready = 0;
            if (val)
                fmtd |= ESS_FMT_STEREO << ESS_ADC_SHIFT;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1094:prog_dmabuf:
ERROR:BLOCK:1090:1094:calling blocking fn stop_adc with lock
&(*(*s).card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*(*s).card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, prog_dmabuf, 1090]

    unsigned bytepersec;
    unsigned bufs;
    unsigned char fmt;
    unsigned long flags;

Start --->
    spin_lock_irqsave(&s->card->lock, flags);

    fmt = s->fmt;
    if (rec) {
Error --->
        stop_adc(s);
        fmt >>= ESS_ADC_SHIFT;
    } else {
        stop_dac(s);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1679:m3_ioctl:
ERROR:BLOCK:1674:1679:calling blocking fn stop_adc with lock
&(*card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1674]

        spin_unlock_irqrestore(&card->lock, flags);
        return 0;

    case SNDCTL_DSP_CHANNELS:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (val != 0) {
            fmtd = 0;
            fmtm = ~0;
            if (file->f_mode & FMODE_READ) {
Error --->
                stop_adc(s);
                s->dma_adc.ready = 0;
                if (val >= 2)
                    fmtd |= ESS_FMT_STEREO << ESS_ADC_SHIFT;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c:1306:snd_korg1212_playback_close:
ERROR:BLOCK:1301:1306:calling blocking fn snd_korg1212_CloseCard with
lock &(*korg1212).lock held [snd_korg1212_CloseCard calling
snd_korg1212_setCardState calling snd_korg1212_TurnOffIdleMonitor
calling snd_korg1212_WaitForCardStopAck calling schedule][START:
&(*korg1212).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c,
snd_korg1212_playback_close, 1301]


#if K1212_DEBUG_LEVEL > 0
		K1212_DEBUG_PRINTK("K1212_DEBUG:
snd_korg1212_playback_close [%s]\n", stateName[korg1212->cardState]);
#endif

Start --->
        spin_lock_irqsave(&korg1212->lock, flags);

        korg1212->playback_substream = NULL;
        korg1212->periodsize = 0;

Error --->
        snd_korg1212_CloseCard(korg1212);

        spin_unlock_irqrestore(&korg1212->lock, flags);
        return 0;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c:1326:snd_korg1212_capture_close:
ERROR:BLOCK:1321:1326:calling blocking fn snd_korg1212_CloseCard with
lock &(*korg1212).lock held [snd_korg1212_CloseCard calling
snd_korg1212_setCardState calling snd_korg1212_TurnOffIdleMonitor
calling snd_korg1212_WaitForCardStopAck calling schedule][START:
&(*korg1212).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c,
snd_korg1212_capture_close, 1321]


#if K1212_DEBUG_LEVEL > 0
		K1212_DEBUG_PRINTK("K1212_DEBUG:
snd_korg1212_capture_close [%s]\n", stateName[korg1212->cardState]);
#endif

Start --->
        spin_lock_irqsave(&korg1212->lock, flags);

        korg1212->capture_substream = NULL;
        korg1212->periodsize = 0;

Error --->
        snd_korg1212_CloseCard(korg1212);

        spin_unlock_irqrestore(&korg1212->lock, flags);
        return 0;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1710:m3_ioctl:
ERROR:BLOCK:1705:1710:calling blocking fn stop_adc with lock
&(*card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1705]

    case SNDCTL_DSP_GETFMTS: /* Returns a mask */
        return put_user(AFMT_U8|AFMT_S16_LE, (int *)arg);

    case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (val != AFMT_QUERY) {
            fmtd = 0;
            fmtm = ~0;
            if (file->f_mode & FMODE_READ) {
Error --->
                stop_adc(s);
                s->dma_adc.ready = 0;
                if (val == AFMT_S16_LE)
                    fmtd |= ESS_FMT_16BIT << ESS_ADC_SHIFT;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/scsi/dpt_i2o.c:1705:adpt_i2o_passthru:
ERROR:BLOCK:1699:1705:calling blocking fn adpt_i2o_post_wait with lock
(*(*pHba).host).host_lock held [adpt_i2o_post_wait calling
kmalloc][START: (*(*pHba).host).host_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/scsi/dpt_i2o.c, adpt_i2o_passthru,
1699]

			sg[i].addr_bus = (u32)virt_to_bus((void*)p);
		}
	}

	do {
Start --->
		spin_lock_irqsave(pHba->host->host_lock, flags);
		// This state stops any new commands from enterring the
		// controller while processing the ioctl
//		pHba->state |= DPTI_STATE_IOCTL;
//		We can't set this now - The scsi subsystem sets
host_blocked and
//		the queue empties and stops.  We need a way to restart
the queue
Error --->
		rcode = adpt_i2o_post_wait(pHba, msg, size, FOREVER);
//		pHba->state &= ~DPTI_STATE_IOCTL;
		spin_unlock_irqrestore(pHba->host->host_lock, flags);
	} while(rcode == -ETIMEDOUT);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:1754:prog_dmabuf:
ERROR:BLOCK:1748:1754:calling blocking fn stop_dac with lock &(*s).lock
held [stop_dac calling apu_set_register calling check_suspend calling
schedule][START: &(*s).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, prog_dmabuf, 1748]

	unsigned bytepersec;
	unsigned bufs;
	unsigned char fmt;
	unsigned long flags;

Start --->
	spin_lock_irqsave(&s->lock, flags);
	fmt = s->fmt;
	if (rec) {
		stop_adc(s);
		fmt >>= ESS_ADC_SHIFT;
	} else {
Error --->
		stop_dac(s);
		fmt >>= ESS_DAC_SHIFT;
	}
	spin_unlock_irqrestore(&s->lock, flags);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1097:prog_dmabuf:
ERROR:BLOCK:1090:1097:calling blocking fn stop_dac with lock
&(*(*s).card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*(*s).card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, prog_dmabuf, 1090]

    unsigned bytepersec;
    unsigned bufs;
    unsigned char fmt;
    unsigned long flags;

Start --->
    spin_lock_irqsave(&s->card->lock, flags);

    fmt = s->fmt;
    if (rec) {
        stop_adc(s);
        fmt >>= ESS_ADC_SHIFT;
    } else {
Error --->
        stop_dac(s);
        fmt >>= ESS_DAC_SHIFT;
    }
    fmt &= ESS_FMT_MASK;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1622:m3_ioctl:
ERROR:BLOCK:1615:1622:calling blocking fn stop_adc with lock
&(*card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1615]


    case SNDCTL_DSP_GETCAPS:
        return put_user(DSP_CAP_DUPLEX | DSP_CAP_REALTIME |
DSP_CAP_TRIGGER | DSP_CAP_MMAP, (int *)arg);

    case SNDCTL_DSP_RESET:
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (file->f_mode & FMODE_WRITE) {
            stop_dac(s);
            synchronize_irq(s->card->pcidev->irq);
            s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count =
s->dma_dac.total_bytes = 0;
        }
        if (file->f_mode & FMODE_READ) {
Error --->
            stop_adc(s);
            synchronize_irq(s->card->pcidev->irq);
            s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count =
s->dma_adc.total_bytes = 0;
        }
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:3738:maestro_resume:
ERROR:BLOCK:3731:3738:calling blocking fn maestro_config with lock
&(*card).lock held [maestro_config calling maestro_read calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, maestro_resume, 3731]

maestro_resume(struct ess_card *card)
{
	unsigned long flags;
	int i;

Start --->
	spin_lock_irqsave(&card->lock,flags); /* over-kill */

	card->in_suspend = 0;

	M_printk("maestro: resuming card at %p\n",card);

	/* restore all our config */
Error --->
	maestro_config(card);
	/* need to restore the base pointers.. */
	if(card->dmapages)
		set_base_registers(&card->channels[0],card->dmapages);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:619:dec_timer_users:
ERROR:BLOCK:611:619:calling blocking fn __m3_assp_write with lock
&(*card).lock held [__m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, dec_timer_users, 611]


static void dec_timer_users(struct m3_card *card)
{
    unsigned long flags;

Start --->
    spin_lock_irqsave(&card->lock, flags);

    card->timer_users--;
    DPRINTK(DPSYS, "dec timer users now %d\n",
            card->timer_users);
    if(card->timer_users > 0 )
        goto out;

Error --->
    __m3_assp_write(card, MEMTYPE_INTERNAL_DATA,
        KDATA_TIMER_COUNT_RELOAD,
         0 ) ;

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2040:m3_open:
ERROR:BLOCK:2032:2040:calling blocking fn set_adc_rate with lock
&(*c).lock held [set_adc_rate calling m3_assp_write calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*c).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_open, 2032]

        if (signal_pending(current))
            return -ERESTARTSYS;
        down(&s->open_sem);
    }

Start --->
    spin_lock_irqsave(&c->lock, flags);

    if (file->f_mode & FMODE_READ) {
        fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_ADC_SHIFT);
        if ((minor & 0xf) == SND_DEV_DSP16)
            fmts |= ESS_FMT_16BIT << ESS_ADC_SHIFT;

        s->dma_adc.ossfragshift = s->dma_adc.ossmaxfrags =
s->dma_adc.subdivision = 0;
Error --->
        set_adc_rate(s, 8000);
    }
    if (file->f_mode & FMODE_WRITE) {
        fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_DAC_SHIFT);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2854:m3_resume:
ERROR:BLOCK:2846:2854:calling blocking fn m3_outw with lock
&(*card).lock held [m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_resume, 2846]

    unsigned long flags;
    int index;
    int i;
    struct m3_card *card = pci_get_drvdata(pci_dev);

Start --->
	spin_lock_irqsave(&card->lock, flags);
    card->in_suspend = 0;

    DPRINTK(DPMOD, "resuming\n");

    /* first lets just bring everything back. .*/

    DPRINTK(DPMOD, "bringing power back on card 0x%p\n",card);
Error --->
    m3_outw(card, 0, 0x54);
    m3_outw(card, 0, 0x56);

    DPRINTK(DPMOD, "restoring pci configs and reseting codec\n");
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1639:m3_ioctl:
ERROR:BLOCK:1631:1639:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1631]

        spin_unlock_irqrestore(&card->lock, flags);
        return 0;

    case SNDCTL_DSP_SPEED:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (val >= 0) {
            if (file->f_mode & FMODE_READ) {
                stop_adc(s);
                s->dma_adc.ready = 0;
                set_adc_rate(s, val);
            }
            if (file->f_mode & FMODE_WRITE) {
Error --->
                stop_dac(s);
                s->dma_dac.ready = 0;
                set_dac_rate(s, val);
            }
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:592:inc_timer_users:
ERROR:BLOCK:584:592:calling blocking fn __m3_assp_write with lock
&(*card).lock held [__m3_assp_write calling m3_outw calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, inc_timer_users, 584]


static void inc_timer_users(struct m3_card *card)
{
    unsigned long flags;

Start --->
    spin_lock_irqsave(&card->lock, flags);

    card->timer_users++;
    DPRINTK(DPSYS, "inc timer users now %d\n",
            card->timer_users);
    if(card->timer_users != 1)
        goto out;

Error --->
    __m3_assp_write(card, MEMTYPE_INTERNAL_DATA,
        KDATA_TIMER_COUNT_RELOAD,
         240 ) ;

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2079:m3_release:
ERROR:BLOCK:2069:2079:calling blocking fn stop_adc with lock
&(*card).lock held [stop_adc calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_release, 2069]

    VALIDATE_STATE(s);
    if (file->f_mode & FMODE_WRITE)
        drain_dac(s, file->f_flags & O_NONBLOCK);

    down(&s->open_sem);
Start --->
    spin_lock_irqsave(&card->lock, flags);

    if (file->f_mode & FMODE_WRITE) {
        stop_dac(s);
        if(s->dma_dac.in_lists) {
            m3_remove_list(s->card, &(s->card->mixer_list),
s->dma_dac.mixer_index);
            nuke_lists(s->card, &(s->dma_dac));
        }
    }
    if (file->f_mode & FMODE_READ) {
Error --->
        stop_adc(s);
        if(s->dma_adc.in_lists) {
            m3_remove_list(s->card, &(s->card->adc1_list),
s->dma_adc.adc1_index);
            nuke_lists(s->card, &(s->dma_adc));
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2807:m3_suspend:
ERROR:BLOCK:2796:2807:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_suspend, 2796]

    unsigned long flags;
    int i;
    struct m3_card *card = pci_get_drvdata(pci_dev);

    /* must be a better way.. */
Start --->
	spin_lock_irqsave(&card->lock, flags);

    DPRINTK(DPMOD, "pm in dev %p\n",card);

    for(i=0;i<NR_DSPS;i++) {
        struct m3_state *s = &card->channels[i];

        if(s->dev_audio == -1)
            continue;

        DPRINTK(DPMOD, "stop_adc/dac() device %d\n",i);
Error --->
        stop_dac(s);
        stop_adc(s);
    }

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c:1765:snd_korg1212_control_analog_put:
ERROR:BLOCK:1753:1765:calling blocking fn
snd_korg1212_WriteADCSensitivity with lock &(*korg1212).lock held
[snd_korg1212_WriteADCSensitivity calling
snd_korg1212_WaitForCardStopAck calling schedule][START:
&(*korg1212).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/pci/korg1212/korg1212.c,
snd_korg1212_control_analog_put, 1753]

{
	korg1212_t *korg1212 = _snd_kcontrol_chip(kcontrol);
	unsigned long flags;
        int change = 0;

Start --->
	spin_lock_irqsave(&korg1212->lock, flags);

        if (u->value.integer.value[0] != korg1212->leftADCInSens) {
                korg1212->leftADCInSens = u->value.integer.value[0];
                change = 1;
        }
        if (u->value.integer.value[1] != korg1212->rightADCInSens) {
                korg1212->rightADCInSens = u->value.integer.value[1];
                change = 1;
        }

        if (change)
Error --->
                snd_korg1212_WriteADCSensitivity(korg1212);

	spin_unlock_irqrestore(&korg1212->lock, flags);

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/ieee1394/ohci1394.c:994:ohci_devctl:
ERROR:BLOCK:982:994:calling blocking fn alloc_dma_rcv_ctx with lock
&(*ohci).IR_channel_lock held [alloc_dma_rcv_ctx calling kmalloc][START:
&(*ohci).IR_channel_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/ieee1394/ohci1394.c, ohci_devctl,
982]

			return -EFAULT;
		}

		mask = (u64)0x1<<arg;

Start --->
                spin_lock_irqsave(&ohci->IR_channel_lock, flags);

		if (ohci->ISO_channel_usage & mask) {
			PRINT(KERN_ERR, ohci->id,
			      "%s: IS0 listen channel %d is already
used",
			      __FUNCTION__, arg);
			spin_unlock_irqrestore(&ohci->IR_channel_lock,
flags);
			return -EFAULT;
		}

		/* activate the legacy IR context */
		if(ohci->ir_legacy_context.ohci == NULL) {
Error --->
			if(alloc_dma_rcv_ctx(ohci,
&ohci->ir_legacy_context,
					     DMA_CTX_ISO, 0,
IR_NUM_DESC,
					     IR_BUF_SIZE,
IR_SPLIT_BUF_SIZE,
					     OHCI1394_IsoRcvContextBase)
< 0) {
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1661:m3_ioctl:
ERROR:BLOCK:1649:1661:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1649]

        spin_unlock_irqrestore(&card->lock, flags);
        return put_user((file->f_mode & FMODE_READ) ? s->rateadc :
s->ratedac, (int *)arg);

    case SNDCTL_DSP_STEREO:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        fmtd = 0;
        fmtm = ~0;
        if (file->f_mode & FMODE_READ) {
            stop_adc(s);
            s->dma_adc.ready = 0;
            if (val)
                fmtd |= ESS_FMT_STEREO << ESS_ADC_SHIFT;
            else
                fmtm &= ~(ESS_FMT_STEREO << ESS_ADC_SHIFT);
        }
        if (file->f_mode & FMODE_WRITE) {
Error --->
            stop_dac(s);
            s->dma_dac.ready = 0;
            if (val)
                fmtd |= ESS_FMT_STEREO << ESS_DAC_SHIFT;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1718:m3_ioctl:
ERROR:BLOCK:1705:1718:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1705]

    case SNDCTL_DSP_GETFMTS: /* Returns a mask */
        return put_user(AFMT_U8|AFMT_S16_LE, (int *)arg);

    case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (val != AFMT_QUERY) {
            fmtd = 0;
            fmtm = ~0;
            if (file->f_mode & FMODE_READ) {
                stop_adc(s);
                s->dma_adc.ready = 0;
                if (val == AFMT_S16_LE)
                    fmtd |= ESS_FMT_16BIT << ESS_ADC_SHIFT;
                else
                    fmtm &= ~(ESS_FMT_16BIT << ESS_ADC_SHIFT);
            }
            if (file->f_mode & FMODE_WRITE) {
Error --->
                stop_dac(s);
                s->dma_dac.ready = 0;
                if (val == AFMT_S16_LE)
                    fmtd |= ESS_FMT_16BIT << ESS_DAC_SHIFT;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1687:m3_ioctl:
ERROR:BLOCK:1674:1687:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling dec_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1674]

        spin_unlock_irqrestore(&card->lock, flags);
        return 0;

    case SNDCTL_DSP_CHANNELS:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);
        if (val != 0) {
            fmtd = 0;
            fmtm = ~0;
            if (file->f_mode & FMODE_READ) {
                stop_adc(s);
                s->dma_adc.ready = 0;
                if (val >= 2)
                    fmtd |= ESS_FMT_STEREO << ESS_ADC_SHIFT;
                else
                    fmtm &= ~(ESS_FMT_STEREO << ESS_ADC_SHIFT);
            }
            if (file->f_mode & FMODE_WRITE) {
Error --->
                stop_dac(s);
                s->dma_dac.ready = 0;
                if (val >= 2)
                    fmtd |= ESS_FMT_STEREO << ESS_DAC_SHIFT;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1363:m3_read:
ERROR:BLOCK:1349:1363:calling blocking fn start_adc with lock
&(*(*s).card).lock held [start_adc calling inc_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*(*s).card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_read, 1349]

        return ret;
    if (!access_ok(VERIFY_WRITE, buffer, count))
        return -EFAULT;
    ret = 0;

Start --->
    spin_lock_irqsave(&s->card->lock, flags);

    while (count > 0) {
        int timed_out;

        swptr = s->dma_adc.swptr;
        cnt = s->dma_adc.dmasize-swptr;
        if (s->dma_adc.count < cnt)
            cnt = s->dma_adc.count;

        if (cnt > count)
            cnt = count;

        if (cnt <= 0) {
Error --->
            start_adc(s);
            if (file->f_flags & O_NONBLOCK)
            {
                ret = ret ? ret : -EAGAIN;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:3704:maestro_suspend:
ERROR:BLOCK:3689:3704:calling blocking fn stop_dac with lock
&(*card).lock held [stop_dac calling apu_set_register calling
check_suspend calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, maestro_suspend, 3689]

maestro_suspend(struct ess_card *card)
{
	unsigned long flags;
	int i,j;

Start --->
	spin_lock_irqsave(&card->lock,flags); /* over-kill */

	... DELETED 9 lines ...


		if(s->dev_audio == -1)
			continue;

		M_printk("maestro: stopping apus for device %d\n",i);
Error --->
		stop_dac(s);
		stop_adc(s);
		for(j=0;j<6;j++)

card->apu_map[s->apu[j]][5]=apu_get_register(s,j,5);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/isdn/i4l/isdn_common.c:933:register_isdn:
ERROR:BLOCK:918:933:calling blocking fn isdn_add_channels with lock
&drivers_lock held [isdn_add_channels calling kmalloc][START:
&drivers_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/isdn/i4l/isdn_common.c,
register_isdn, 918]

	drv->fi.state = ST_DRV_NULL;
	drv->fi.debug = 1;
	drv->fi.userdata = drv;
	drv->fi.printdebug = drv_debug;

Start --->
	spin_lock_irqsave(&drivers_lock, flags);

	... DELETED 9 lines ...


	if (__isdn_drv_lookup(iif->id) >= 0)
		goto fail_unlock;

	strcpy(drv->id, iif->id);
Error --->
	if (isdn_add_channels(drv, iif->channels))
		goto fail_unlock;

	drv->di = drvidx;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2048:m3_open:
ERROR:BLOCK:2032:2048:calling blocking fn set_dac_rate with lock
&(*c).lock held [set_dac_rate calling m3_assp_write calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*c).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_open, 2032]

        if (signal_pending(current))
            return -ERESTARTSYS;
        down(&s->open_sem);
    }

Start --->
    spin_lock_irqsave(&c->lock, flags);

	... DELETED 10 lines ...

        fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_DAC_SHIFT);
        if ((minor & 0xf) == SND_DEV_DSP16)
            fmts |= ESS_FMT_16BIT << ESS_DAC_SHIFT;

        s->dma_dac.ossfragshift = s->dma_dac.ossmaxfrags =
s->dma_dac.subdivision = 0;
Error --->
        set_dac_rate(s, 8000);
    }
    set_fmt(s, fmtm, fmts);
    s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2813:m3_suspend:
ERROR:BLOCK:2796:2813:calling blocking fn m3_assp_halt with lock
&(*card).lock held [m3_assp_halt calling m3_inb calling check_suspend
calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_suspend, 2796]

    unsigned long flags;
    int i;
    struct m3_card *card = pci_get_drvdata(pci_dev);

    /* must be a better way.. */
Start --->
	spin_lock_irqsave(&card->lock, flags);

	... DELETED 11 lines ...

        stop_adc(s);
    }

    mdelay(10); /* give the assp a chance to idle.. */

Error --->
    m3_assp_halt(card);

    if(card->suspend_mem) {
        int index = 0;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:2050:m3_open:
ERROR:BLOCK:2032:2050:calling blocking fn set_fmt with lock &(*c).lock
held [set_fmt calling m3_assp_write calling __m3_assp_write calling
m3_outw calling check_suspend calling schedule][START: &(*c).lock,
unknown->locked, /home/junfeng/linux-2.5.63/sound/oss/maestro3.c,
m3_open, 2032]

        if (signal_pending(current))
            return -ERESTARTSYS;
        down(&s->open_sem);
    }

Start --->
    spin_lock_irqsave(&c->lock, flags);

	... DELETED 12 lines ...

            fmts |= ESS_FMT_16BIT << ESS_DAC_SHIFT;

        s->dma_dac.ossfragshift = s->dma_dac.ossmaxfrags =
s->dma_dac.subdivision = 0;
        set_dac_rate(s, 8000);
    }
Error --->
    set_fmt(s, fmtm, fmts);
    s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);

    up(&s->open_sem);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1668:m3_ioctl:
ERROR:BLOCK:1649:1668:calling blocking fn set_fmt with lock
&(*card).lock held [set_fmt calling m3_assp_write calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1649]

        spin_unlock_irqrestore(&card->lock, flags);
        return put_user((file->f_mode & FMODE_READ) ? s->rateadc :
s->ratedac, (int *)arg);

    case SNDCTL_DSP_STEREO:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);

	... DELETED 13 lines ...

            if (val)
                fmtd |= ESS_FMT_STEREO << ESS_DAC_SHIFT;
            else
                fmtm &= ~(ESS_FMT_STEREO << ESS_DAC_SHIFT);
        }
Error --->
        set_fmt(s, fmtm, fmtd);
        spin_unlock_irqrestore(&card->lock, flags);
        return 0;

---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1694:m3_ioctl:
ERROR:BLOCK:1674:1694:calling blocking fn set_fmt with lock
&(*card).lock held [set_fmt calling m3_assp_write calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1674]

        spin_unlock_irqrestore(&card->lock, flags);
        return 0;

    case SNDCTL_DSP_CHANNELS:
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);

	... DELETED 14 lines ...

                if (val >= 2)
                    fmtd |= ESS_FMT_STEREO << ESS_DAC_SHIFT;
                else
                    fmtm &= ~(ESS_FMT_STEREO << ESS_DAC_SHIFT);
            }
Error --->
            set_fmt(s, fmtm, fmtd);
        }
        spin_unlock_irqrestore(&card->lock, flags);
        return put_user((s->fmt & ((file->f_mode & FMODE_READ) ?
(ESS_FMT_STEREO << ESS_ADC_SHIFT)
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/net/wan/comx-hw-munich.c:1458:MUNICH_open:
ERROR:BLOCK:1438:1458:calling blocking fn kmalloc with lock &mister_lock
held [kmalloc][START: &mister_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/net/wan/comx-hw-munich.c,
MUNICH_open, 1438]

	printk("MUNICH_open: no %s board with boardnum = %d\n",
	       ch->hardware->name, hw->boardnum);
	return -ENODEV;
    }

Start --->
    spin_lock_irqsave(&mister_lock, flags);

	... DELETED 14 lines ...

	    board->histogram[i] = 0;

	board->lineup = 0;

	/* Allocate CCB: */
Error --->
        board->ccb = kmalloc(sizeof(munich_ccb_t), GFP_KERNEL);
	if (board->ccb == NULL)
	{
	    spin_unlock_irqrestore(&mister_lock, flags);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1725:m3_ioctl:
ERROR:BLOCK:1705:1725:calling blocking fn set_fmt with lock
&(*card).lock held [set_fmt calling m3_assp_write calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_ioctl, 1705]

    case SNDCTL_DSP_GETFMTS: /* Returns a mask */
        return put_user(AFMT_U8|AFMT_S16_LE, (int *)arg);

    case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
        get_user_ret(val, (int *)arg, -EFAULT);
Start --->
        spin_lock_irqsave(&card->lock, flags);

	... DELETED 14 lines ...

                if (val == AFMT_S16_LE)
                    fmtd |= ESS_FMT_16BIT << ESS_DAC_SHIFT;
                else
                    fmtm &= ~(ESS_FMT_16BIT << ESS_DAC_SHIFT);
            }
Error --->
            set_fmt(s, fmtm, fmtd);
        }
        spin_unlock_irqrestore(&card->lock, flags);
        return put_user((s->fmt & ((file->f_mode & FMODE_READ) ?
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1451:m3_write:
ERROR:BLOCK:1430:1451:calling blocking fn start_dac with lock
&(*(*s).card).lock held [start_dac calling inc_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][START: &(*(*s).card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_write, 1430]

        return ret;
    if (!access_ok(VERIFY_READ, buffer, count))
        return -EFAULT;
    ret = 0;

Start --->
    spin_lock_irqsave(&s->card->lock, flags);

	... DELETED 15 lines ...


        if (cnt > count)
            cnt = count;

        if (cnt <= 0) {
Error --->
            start_dac(s);
            if (file->f_flags & O_NONBLOCK) {
                if(!ret) ret = -EAGAIN;
                goto out;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro.c:3713:maestro_suspend:
ERROR:BLOCK:3689:3713:calling blocking fn stop_bob with lock
&(*card).lock held [stop_bob calling maestro_read calling check_suspend
calling schedule][START: &(*card).lock, unknown->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro.c, maestro_suspend, 3689]

maestro_suspend(struct ess_card *card)
{
	unsigned long flags;
	int i,j;

Start --->
	spin_lock_irqsave(&card->lock,flags); /* over-kill */

	... DELETED 18 lines ...


	}

	/* get rid of interrupts? */
	if( card->dsps_open > 0)
Error --->
		stop_bob(&card->channels[0]);

	card->in_suspend++;

---------------------------------------------------------
[BUG] interesting things to check: calling kmalloc with GFP_KERNEL and
then with GFP_ATOMIC.
/home/junfeng/linux-2.5.63/net/rose/rose_route.c:112:rose_add_node:
ERROR:BLOCK:64:112:calling blocking fn kmalloc with lock
&rose_neigh_list_lock held [kmalloc][START: &rose_neigh_list_lock,
unknown->locked, /home/junfeng/linux-2.5.63/net/rose/rose_route.c,
rose_add_node, 64]

	struct rose_node  *rose_node, *rose_tmpn, *rose_tmpp;
	struct rose_neigh *rose_neigh;
	int i, res = 0;

	spin_lock_bh(&rose_node_list_lock);
Start --->
	spin_lock_bh(&rose_neigh_list_lock);

	... DELETED 42 lines ...


		init_timer(&rose_neigh->ftimer);
		init_timer(&rose_neigh->t0timer);

		if (rose_route->ndigis != 0) {
Error --->
			if ((rose_neigh->digipeat =
kmalloc(sizeof(ax25_digi), GFP_KERNEL)) == NULL) {
				kfree(rose_neigh);
				res = -ENOMEM;
				goto out;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1403:m3_read:
ERROR:BLOCK:1349:1403:calling blocking fn start_adc with lock
&(*(*s).card).lock held [start_adc calling inc_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][TRANS: &(*(*s).card).lock, unlocked->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_read, 1395]

        return ret;
    if (!access_ok(VERIFY_WRITE, buffer, count))
        return -EFAULT;
    ret = 0;

Start --->
    spin_lock_irqsave(&s->card->lock, flags);

	... DELETED 48 lines ...

        s->dma_adc.swptr = swptr;
        s->dma_adc.count -= cnt;
        count -= cnt;
        buffer += cnt;
        ret += cnt;
Error --->
        start_adc(s);
    }

out:
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c:1491:m3_write:
ERROR:BLOCK:1430:1491:calling blocking fn start_dac with lock
&(*(*s).card).lock held [start_dac calling inc_timer_users calling
__m3_assp_write calling m3_outw calling check_suspend calling
schedule][TRANS: &(*(*s).card).lock, unlocked->locked,
/home/junfeng/linux-2.5.63/sound/oss/maestro3.c, m3_write, 1478]

        return ret;
    if (!access_ok(VERIFY_READ, buffer, count))
        return -EFAULT;
    ret = 0;

Start --->
    spin_lock_irqsave(&s->card->lock, flags);

	... DELETED 55 lines ...

        s->dma_dac.count += cnt;
        s->dma_dac.endcleared = 0;
        count -= cnt;
        buffer += cnt;
        ret += cnt;
Error --->
        start_dac(s);
    }
out:
    spin_unlock_irqrestore(&s->card->lock, flags);
---------------------------------------------------------
[BUG] such a huge ioctl function ...
/home/junfeng/linux-2.5.63/drivers/net/wan/lmc/lmc_main.c:500:lmc_ioctl:
ERROR:BLOCK:160:500:calling blocking fn kmalloc with lock
&(*sc).lmc_lock held [kmalloc][START: &(*sc).lmc_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/net/wan/lmc/lmc_main.c, lmc_ioctl,
160]


    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 334 lines ...

                    if(xc.data == 0x0){
                            ret = -EINVAL;
                            break;
                    }

Error --->
                    data = kmalloc(xc.len, GFP_KERNEL);
                    if(data == 0x0){
                            printk(KERN_WARNING "%s: Failed to allocate
memory for copy\n", dev->name);
                            ret = -ENOMEM;


