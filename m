Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVGVNPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVGVNPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVGVNPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:15:36 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33697 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261262AbVGVNPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:15:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
Date: Fri, 22 Jul 2005 16:14:59 +0300
User-Agent: KMail/1.5.4
References: <20050721180621.GA25829@charite.de> <20050722062548.GJ25829@charite.de>
In-Reply-To: <20050722062548.GJ25829@charite.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200507221614.28096.vda@ilport.com.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 July 2005 09:25, Ralf Hildebrandt wrote:
> * Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> 
> > The one message strinking me as odd during the boot-process is:
> > Jul 21 19:50:01 kasbah kernel: AC'97 warm reset still in progress? [0xffffffff]
> 
> More details: If I unload the sounddriver:
> 
> # rmmod snd_intel8x0
> 
> and the reload it:
> 
> # modprobe snd_intel8x0
> 
> I get:
> 
> ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> AC'97 warm reset still in progress? [0xffffffff]
> Intel ICH: probe of 0000:00:06.0 failed with error -5

Not happening here on 2.6.12:

# modprobe -r snd_intel8x0
# modprobe snd_intel8x0
# dmesg | tail -4
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50417 usecs
intel8x0: clocking to 48000
# lspci -n
00:00.0 Class 0600: 8086:1130 (rev 04)
00:02.0 Class 0300: 8086:1132 (rev 04)
00:1e.0 Class 0604: 8086:244e (rev 05)
00:1f.0 Class 0601: 8086:2440 (rev 05)
00:1f.1 Class 0101: 8086:244b (rev 05)
00:1f.2 Class 0c03: 8086:2442 (rev 05)
00:1f.3 Class 0c05: 8086:2443 (rev 05)
00:1f.4 Class 0c03: 8086:2444 (rev 05)
00:1f.5 Class 0401: 8086:2445 (rev 05)
01:08.0 Class 0200: 8086:2449 (rev 03)
# lspci
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)

In your case, 0xffffffff looks like device is disabled. This is where it happens:

static int snd_intel8x0_chip_init(intel8x0_t *chip, int probing)
{
        unsigned int i;
        int err;

        if (chip->device_type != DEVICE_ALI) {
                if ((err = snd_intel8x0_ich_chip_init(chip, probing)) < 0)
                        return err;
...

static int snd_intel8x0_ich_chip_init(intel8x0_t *chip, int probing)
{
        unsigned long end_time;
        unsigned int cnt, status, nstatus;

        /* put logic to right state */
        /* first clear status bits */
        status = ICH_RCS | ICH_MCINT | ICH_POINT | ICH_PIINT;
        if (chip->device_type == DEVICE_NFORCE)
                status |= ICH_NVSPINT;
        cnt = igetdword(chip, ICHREG(GLOB_STA));
        iputdword(chip, ICHREG(GLOB_STA), cnt & status);

        /* ACLink on, 2 channels */
        cnt = igetdword(chip, ICHREG(GLOB_CNT));
        cnt &= ~(ICH_ACLINK | ICH_PCM_246_MASK);
        /* finish cold or do warm reset */
        cnt |= (cnt & ICH_AC97COLD) == 0 ? ICH_AC97COLD : ICH_AC97WARM;
        iputdword(chip, ICHREG(GLOB_CNT), cnt);
        end_time = (jiffies + (HZ / 4)) + 1;
        do {
                if ((igetdword(chip, ICHREG(GLOB_CNT)) & ICH_AC97WARM) == 0)
                        goto __ok;
                do_delay(chip);
        } while (time_after_eq(end_time, jiffies));
        snd_printk("AC'97 warm reset still in progress? [0x%x]\n", igetdword(chip, ICHREG(GLOB_CNT)));
        return -EIO;

      __ok:
...

Dunno what to do next. Shots in the dark:

Did it wok with 2.6.12 for you?

Maybe start adding printks in snd_intel8x0_create(),
where snd_intel8x0_chip_init() is eventually called.
You want to find out what is the difference in hw behaviour
bebween good and bad boot.

Maybe do a superfluous pci_disable_device/pci_enable_device pair there.
--
vda

