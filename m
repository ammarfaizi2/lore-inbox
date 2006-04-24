Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWDXRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWDXRpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWDXRpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:45:07 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:14099 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1751041AbWDXRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:45:05 -0400
Subject: Re: [linuxsh-dev] Re: [Alsa-devel] [PATCH] Add Dreamcast AICA
	driver to alsa-driver
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Paul Mundt <lethal@linux-sh.org>
In-Reply-To: <s5hacab44bw.wl%tiwai@suse.de>
References: <1145831786.9242.38.camel@localhost.localdomain>
	 <1145832383.9242.41.camel@localhost.localdomain>
	 <s5hacab44bw.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 18:44:55 +0100
Message-Id: <1145900695.9243.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 13:10 +0200, Takashi Iwai wrote:
> At Sun, 23 Apr 2006 23:46:22 +0100,
> Adrian McMenamin wrote:
> +/* module parameters */
> +#define CARD_NAME "AICA"
> +
> +static int index;
> 
> Initialize it to -1 (or SNDRV_DEFAULT_IDX1), and pass it to the first
> argument of snd_card_new().  Otherwise this option is useless.
> 
OK

> 
> > +/* Spinlocks */
> > +DEFINE_SPINLOCK(spu_memlock);
> 
> Missing static.
> 

OK

> 
> > +/* spu_memset - write to memory in SPU address space */
> > +static void spu_memset(uint32_t toi, void __iomem * what, int length)
> > +{
> > +	uint32_t *to = (uint32_t *) (SPU_MEMORY_BASE + toi);
> > +	int i;
> > +	if (length % 4)
> > +		length = (length / 4) + 1;
> > +	else
> > +		length = length / 4;
> 
> If you use writel(), the length must be aligned to 4.
> 
> 
> > +	spu_write_wait();
> > +	for (i = 0; i < length; i++) {
> > +		spin_lock(&spu_memlock);
> > +		writel(what, to);
> > +		spin_unlock(&spu_memlock);
> 
> What's the purpose of this lock?
> 
If I add more than one instance to the driver, which could be done, it's
to stop two instances attempting to write to the ARM7 memory space
concurrently.



> 
> > +		to++;
> > +		if (i && !(i % 8))
> > +			spu_write_wait();
> > +	}
> > +}
> > +
> > +/* spu_memload - write to SPU address space */
> > +static void spu_memload(uint32_t toi, void __iomem * from, int length)
> > +{
> > +	uint32_t __iomem *froml = from;
> > +	uint32_t __iomem *to =
> > +	    (uint32_t __iomem *) (SPU_MEMORY_BASE + toi);
> > +	int i, val;
> > +	if (length % 4)
> > +		length = (length / 4) + 1;
> > +	else
> > +		length = length / 4;
> 
> Ditto.
> 
> 
> > +/* spu_disable - set spu registers to stop sound output */
> > +static void spu_disable(void)
> > +{
> > +	int i;
> > +	uint32_t regval;
> > +	spu_write_wait();
> > +	regval = readl(ARM_RESET_REGISTER);
> > +	regval |= 1;
> > +	spu_write_wait();
> > +	spin_lock(&spu_memlock);
> > +	writel(regval, ARM_RESET_REGISTER);
> > +	spin_unlock(&spu_memlock);
> > +	for (i = 0; i < 64; i++) {
> > +		spu_write_wait();
> > +		regval = readl(SPU_REGISTER_BASE + (i * 0x80));
> > +		regval = (regval & ~0x4000) | 0x8000;
> > +		spu_write_wait();
> > +		spin_lock(&spu_memlock);
> > +		writel(regval, SPU_REGISTER_BASE + (i * 0x80));
> > +		spin_unlock(&spu_memlock);
> 
> For what is this lock?
> 
> 
> > +/* aica_chn_start - write to spu to start playback */
> > +inline static void aica_chn_start(void)
> > +{
> > +	spu_write_wait();
> > +	spin_lock(&spu_memlock);
> > +	writel(AICA_CMD_KICK | AICA_CMD_START,
> > +	       (uint32_t *) AICA_CONTROL_POINT);
> 
> The cast looks strange...
> 
> 
> > +	spin_unlock(&spu_memlock);
> > +}
> > +
> > +/* aica_chn_halt - write to spu to halt playback */
> > +inline static void aica_chn_halt(void)
> > +{
> > +	spu_write_wait();
> > +	spin_lock(&spu_memlock);
> > +	writel(AICA_CMD_KICK | AICA_CMD_STOP,
> > +	       (uint32_t *) AICA_CONTROL_POINT);
> > +	spin_unlock(&spu_memlock);
> > +}
> > +
> > +/* ALSA code below */
> > +static struct snd_pcm_hardware snd_pcm_aica_playback_hw = {
> > +	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),.formats =
> > +	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
> > +	     SNDRV_PCM_FMTBIT_IMA_ADPCM),.rates =
> > +	    SNDRV_PCM_RATE_8000_48000,.rate_min = 8000,.rate_max =
> > +	    48000,.channels_min = 1,.channels_max = 2,.buffer_bytes_max =
> > +	    AICA_BUFFER_SIZE,.period_bytes_min =
> > +	    AICA_PERIOD_SIZE,.period_bytes_max =
> > +	    AICA_PERIOD_SIZE,.periods_min =
> > +	    AICA_PERIOD_NUMBER,.periods_max = AICA_PERIOD_NUMBER,
> > +};
> 
> Put the field ids to the beginning of the line.  Found in other
> structs, too.
> 

Indent messed up my code. I'll fix that.


> 
> > +static int stereo_buffer_transfer(struct snd_pcm_substream
> > +				  *substream, int buffer_size, int period)
> > +{
> 
> I feel this transfer-and-wait could be done more efficiently using
> workq than doing it in timer callback.  The trigger(start) and
> aica_period_elapsed() calls queue_work() at each time.
> 
> The most work of spu_begin_dma() should be put in the workq, too.
> 

heh. If you remember, a couple of months ago I had this in a kernel
thread - ie much the same - and you or Lee said I should absolutely not
use that mechanism :)


> 
> > +	int transferred;
> > +	int dma_countout;
> > +	struct snd_pcm_runtime *runtime;
> > +	int period_offset;
> > +	long dma_flags;
> > +	period_offset = period;
> > +	period_offset %= (AICA_PERIOD_NUMBER / 2);
> > +	runtime = substream->runtime;
> > +	/* transfer left and then right */
> > +	dma_flags = claim_dma_lock();
> > +	dma_countout = 0;
> > +	dma_xfer(0,
> > +		 runtime->dma_area + (AICA_PERIOD_SIZE * period_offset),
> > +		 AICA_CHANNEL0_OFFSET +
> > +		 (AICA_PERIOD_SIZE * period_offset), buffer_size / 2, 5);
> > +	/* wait for completion */
> > +	do {
> > +		udelay(5);
> > +		transferred = get_dma_residue(0);
> > +		dma_countout++;
> > +		if (dma_countout > 0x10000)
> > +			break;	/* Approx 1/3 sec timeout in case of hardware failure */
> > +	}
> > +	while (transferred < buffer_size / 2);
> > +	dma_xfer(0,
> > +		 AICA_BUFFER_SIZE / 2 + runtime->dma_area +
> > +		 (AICA_PERIOD_SIZE * period_offset),
> > +		 AICA_CHANNEL1_OFFSET +
> > +		 (AICA_PERIOD_SIZE * period_offset), buffer_size / 2, 5);
> > +	/* have to wait again */
> > +	dma_countout = 0;
> > +	do {
> > +		udelay(5);
> > +		transferred = get_dma_residue(0);
> > +		dma_countout++;
> > +		if (dma_countout > 0x10000)
> > +			break;
> > +	}
> > +	while (transferred < buffer_size / 2);
> > +	release_dma_lock(dma_flags);
> > +	return 0;
> > +}
> 
> You can write a single function for both mono and two-channel
> streams.
> 

How can I do that given the dma has to be serialised?

> 
> > +static int snd_aicapcm_pcm_open(struct snd_pcm_substream
> > +				*substream)
> > +{
> > +	struct snd_pcm_runtime *runtime;
> > +	struct aica_channel *channel;
> > +	struct snd_card_aica *dreamcastcard;
> > +	if (!enable)
> > +		return -ENOENT;
> 
> You don't need to check enable here.
> 
> The "enable" module option was introduced to enable/disable the
> speicfic device when multiple same devices are on the system.  Hence
> it makes no sense for the drivers that support only a single device.
> But we keep this option as a dummy one in most of drivers just for
> compatibility reason.  The sound configurator tends to set this option
> unconditionally.
> 
> 
> > +/* TO DO: set up to handle more than one pcm instance */
> > +static int __init snd_aicapcmchip(struct snd_card_aica
> > +				  *dreamcastcard, int pcm_index)
> 
> Use __devinit prefix as long as you use platform_driver.
> 
> 
> > +static int remove_dreamcastcard(struct device *dreamcast_device)
> > +{
> > +	struct snd_card_aica *dreamcastcard =
> > +	    dreamcast_device->driver_data;
> > +	snd_card_free(dreamcastcard->card);
> > +	kfree(dreamcastcard);
> > +	return 0;
> > +}
> > +
> > +static struct device_driver aica_driver = {
> > +	.name = "AICA",.bus = &platform_bus_type,
> > +	.remove = remove_dreamcastcard,
> > +};
> 
> Any reason not to use struct platform_driver?
> 
> 
> > +static int load_aica_firmware()
> > +{
> > +	int err;
> > +	err = 0;
> > +	spu_init();
> > +	const struct firmware *fw_entry;
> 
> The variable definition must be in the beginning of the function
> block.
> 
> 
> > +static int __init aica_init(void)
> > +{
> > +	int err;
> > +	struct snd_card_aica *dreamcastcard;
> > +	/* Are we in a Dreamcast at all? */
> > +	if (!mach_is_dreamcast())
> > +		return -ENODEV;
> 
> The typical flow in init entry should be:
> 
> 	- register platform_driver
> 	- register platform_device	
> 	  -> initialize the card and releveant instances in probe
> 	     callback
> 
> 
> BTW, with the latest HG repo, you can add alsa-driver/Kconfig, so that
> you can keep alsa-kernel tree intact.

hmmm, I have no HG tools. I'll have to get some. My distro seems to have
none available

