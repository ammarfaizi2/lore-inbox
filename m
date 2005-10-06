Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVJFQAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVJFQAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVJFQAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:00:35 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:3470 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbVJFQAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:00:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=piGlRehoxL2rBdp5Z2VDw4E0DE4la/J0zosioNr1JWN61BK5Bro6hVHf+0fVQ+3zTb97B2CZIJ4p6MNfs0tENZQwcLV+4AG45pvM3xLrW/w7d/PcAcDgLsFszit6D6beleb7cMTiLld9HOPckuWkWmefT5xGQSxcOmxQe/3Ieho=
Message-ID: <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
Date: Thu, 6 Oct 2005 09:00:32 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051006083043.GB21800@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13923_10171058.1128614432939"
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
	 <20051006083043.GB21800@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13923_10171058.1128614432939
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

NOTE: THere are many messages I haven't read through yet so I may send
more data later as per requests there.

On 10/6/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > Hi,
> >    This is nothing particularily new. I'm just presenting it to
> > represent what I'm seeign and get some guidance about how to find out
> > what's going on.
>
> lets first check whether all the RT priorities are set up correctly for
> your audio setup. Could you send me your /proc/interrupts, your .config
> and the output of:
>
>   ps -eo pid,pri,rtprio,cmd
>
> there are lots of built-in methods in the -rt kernel to figure out the
> source of latencies. If the default methods do not show anything then
> worst-case we can activate the kernel's latency tracer to record the
> actual xrun critical path.
>
>         Ingo
>

Hi Ingo,
   OK, so starting the day I saw that you had posted -rt10 so that's
what I'm working with now:

lightning ~ # uname -a
Linux lightning 2.6.14-rc3-rt10 #1 SMP PREEMPT Thu Oct 6 08:14:03 PDT
2005 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
lightning ~ #


The sound card that is critical to this machine is the hdsp one at IRQ
58. The one at 225 is not used in realtime mode.

lightning ~ # cat /proc/interrupts
           CPU0
  0:      39462    IO-APIC-edge  timer
  1:        210    IO-APIC-edge  i8042
  7:          2    IO-APIC-edge  lpptest
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       6286    IO-APIC-edge  i8042
 14:         48    IO-APIC-edge  ide0
 50:          2   IO-APIC-level  ehci_hcd:usb1
 58:       3922   IO-APIC-level  hdsp
 66:          2   IO-APIC-level  ohci1394
217:      13592   IO-APIC-level  ohci_hcd:usb2, eth0
225:          0   IO-APIC-level  libata, NVidia CK804
233:      11973   IO-APIC-level  libata
NMI:         72
LOC:      39417
ERR:          1
MIS:          0
lightning ~ #

lightning ~ # cat /proc/asound/cards
0 [CK804          ]: NFORCE - NVidia CK804
                     NVidia CK804 with ALC850 at 0xda103000, irq 225
1 [DSP            ]: H-DSP - Hammerfall DSP
                     RME Hammerfall HDSP 9652 at 0xda000000, irq 58
lightning ~ #

lightning ~ # ps -eo pid,pri,rtprio,cmd
  PID PRI RTPRIO CMD
    1  23      - init [3]
    2 139     99 [migration/0]
    3  41      1 [softirq-high/0]
    4  41      1 [softirq-timer/0]
    5  41      1 [softirq-net-tx/]
    6  41      1 [softirq-net-rx/]
    7  41      1 [softirq-scsi/0]
    8  41      1 [softirq-tasklet]
    9  34      - [desched/0]
   10  41      1 [events/0]
   11  28      - [khelper]
   12  28      - [kthread]
   14  19      - [kacpid]
   15  89     49 [IRQ 9]
  130  29      - [kblockd/0]
  133  29      - [khubd]
  202  22      - [pdflush]
  203  24      - [pdflush]
  205  27      - [aio/0]
  204  14      - [kswapd0]
  798  88     48 [IRQ 8]
  801  87     47 [IRQ 7]
  802  29      - [kseriod]
  805  86     46 [IRQ 12]
  815  85     45 [IRQ 6]
  850  84     44 [IRQ 14]
  861  29      - [ata/0]
  865  27      - [scsi_eh_0]
  866  27      - [scsi_eh_1]
  867  83     43 [IRQ 225]
  870  27      - [scsi_eh_2]
  871  27      - [scsi_eh_3]
  872  82     42 [IRQ 233]
  887  81     41 [IRQ 50]
  893  80     40 [IRQ 217]
  908  79     39 [IRQ 1]
  912  24      - [kjournald]
  970  26      - udevd
 4545  78     38 [IRQ 58]
 4599  24      - [khpsbpkt]
 4694  77     37 [IRQ 66]
 4695  23      - [knodemgrd_0]
 6321  24      - /usr/sbin/syslog-ng
 7111  23      - /usr/sbin/cupsd
7117  76     36 [IRQ 4]
 7188  22      - /usr/sbin/sshd
 7224  23      - /usr/sbin/cron
 7343  23      - /sbin/portmap
 7370  27      - [rpciod/0]
 7371  23      - [lockd]
 7394  22      - /sbin/agetty 38400 tty1 linux
 7398  22      - /sbin/agetty 38400 tty2 linux
 7400  22      - /sbin/agetty 38400 tty3 linux
 7401  23      - /sbin/agetty 38400 tty4 linux
 7408  23      - /sbin/agetty 38400 tty5 linux
 7409  23      - /sbin/agetty 38400 tty6 linux
 7527  23      - /usr/bin/gdm
 7529  23      - /usr/bin/gdm
 7534  23      - /usr/X11R6/bin/X :0 -audit 0 -auth /var/gdm/:0.Xauth
-nolisten tcp vt7
 7567  23      - gnome-session
 7582  23      - /usr/bin/ssh-agent -- gnome-session
 7584  23      - /usr/libexec/gconfd-2 5
 7587  21      - /usr/bin/gnome-keyring-daemon
 7589  23      - /usr/libexec/bonobo-activation-server --ac-activate
--ior-output-fd=3D19
 7591  23      - /usr/libexec/gnome-settings-daemon
--oaf-activate-iid=3DOAFIID:GNOME_SettingsDaemon --oa 7601  24      -
xscreensaver -nosplash
 7627  24      - metacity --sm-save-file 1126471293-7521-180409387.ms
 7629  23      - nautilus --sm-config-prefix /nautilus-pR56zY/
--sm-client-id 11c0a80138000112560470300 7631  23      - gnome-panel
--sm-config-prefix /gnome-panel-Ckbfvi/ --sm-client-id
11c0a80138000112627 7648  23      - /usr/libexec/gnome-vfs-daemon
--oaf-activate-iid=3DOAFIID:GNOME_VFS_Daemon_Factory --oaf 7656  23    =20
- /usr/libexec/mapping-daemon
 7659  24      - /usr/libexec/mixer_applet2
--oaf-activate-iid=3DOAFIID:GNOME_MixerApplet_Factory --oaf-i 7661  23 =20
   - /usr/libexec/clock-applet
--oaf-activate-iid=3DOAFIID:GNOME_ClockApplet_Factory --oaf-io 7663  23=20
    - /usr/libexec/wnck-applet
--oaf-activate-iid=3DOAFIID:GNOME_Wncklet_Factory --oaf-ior-fd=3D 7665  23
     - /usr/bin/gnome-terminal
 7666  21      - gnome-pty-helper
 7667  24      - bash
 7672  22      - su -
 7675  23      - -bash
 8398  24      - hdspmixer
 8400  24      - qjackctl
 8402  20      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
 8410  23      - /bin/bash /usr/libexec/mozilla-launcher
 8421  24      - /opt/firefox/firefox-bin
 8437  22      - ps -eo pid,pri,rtprio,cmd
lightning ~ #


Even with Jack running I don't see the jackd process getting any
special priority. Is this correct, or is that part that gets higher
prioity just not listed here.

.config attached.

Thanks!

- Mark

------=_Part_13923_10171058.1128614432939
Content-Type: application/x-bzip2; name=knecht.config-2.6.14-rc3-rt10.bz2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="knecht.config-2.6.14-rc3-rt10.bz2"

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
ujxvgNu4oCf/i7kinChIUkjTBQA=
------=_Part_13923_10171058.1128614432939--
