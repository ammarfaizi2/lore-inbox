Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbTCIPA4>; Sun, 9 Mar 2003 10:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbTCIPA4>; Sun, 9 Mar 2003 10:00:56 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:13785 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262517AbTCIPAr>; Sun, 9 Mar 2003 10:00:47 -0500
Date: Mon, 10 Mar 2003 02:09:21 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64 - sysfs/pcmcia oops?
Message-ID: <20030309150921.GA450@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> From: Russell King <rmk@arm.linux.org.uk>
> 
> On Sun, Mar 09, 2003 at 01:06:27AM +1100, CaT wrote:
> > I ejected the card and didn't get any errors about freeing memory. On
> > reinsert I got both devices activated. Then I ejected and reinserted
> > quickly and got an oops that resulted in the keyboard being locked up. I
> > can still ssh into the box and type this email though. Here's the dmesg:
> 
> I suspect this isn't to do with my changes - it looks like something in
> the networking / sysfs layer went pop.  Could you send this oops to lkml
> please?

No problem. Below is an extract of my message to Russel. It contains the
oops and what I did to get it. I'll also attach the patches I applied to
the kernel in order to a. get it to compile, b. get it to boot and c.
get it to play with my xircom pcmcia card (there's a few and I left them
gzipped to save space).

Any questions/request for testing, please yell.

---8<---
Huzzah! That it does. Apart from not being able to dail out atm (no
phone line avail) both the serial modem side and ethernet side work
groovily (I get responces to AT commands from the modem side, and the
ethernet side is still passing packets adequately :)

I ejected the card and didn't get any errors about freeing memory. On
reinsert I got both devices activated. Then I ejected and reinserted
quickly and got an oops that resulted in the keyboard being locked up. I
can still ssh into the box and type this email though. Here's the dmesg:

cs: cb_free(bus 2)
cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
PCI: Enabling device 02:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 02:00.0 to 64
eth1: Xircom cardbus revision 3 at irq 10 
PCI: Enabling device 02:00.1 (0000 -> 0003)
ttyS15 at I/O 0x1880 (irq = 10) is a 16550A
------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01a14fd>]    Not tainted
EFLAGS: 00010246
EIP is at sysfs_remove_dir+0x19/0x15c
eax: 00000000   ebx: cfd5c9cc   ecx: cfd5c800   edx: 00000000
esi: cfdc2744   edi: cfd5c800   ebp: c12fbdf4   esp: c12fbdd8
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c12fa000 task=c12fecc0)
Stack: cfd5c9cc cfd5c800 cfd5c800 c0131dce c05b46d4 00000006 cfd5c800 c12fbe04 
       c023b365 cfd5c9cc cfd5c9cc c12fbe14 c023b381 cfd5c9cc c12fa000 c12fbe34 
       c03a2f28 cfd5c9cc cfd5c800 cfd5c800 cfd5cc4c cfd5c9cc 00000077 c12fbe44 
Call Trace:
 [<c0131dce>] notifier_call_chain+0x1e/0x3c
 [<c023b365>] kobject_del+0xd/0x1c
 [<c023b381>] kobject_unregister+0xd/0x1c
 [<c03a2f28>] unregister_netdevice+0x23c/0x260
 [<c02d39fa>] unregister_netdev+0x12/0x28
 [<c02e35a2>] xircom_remove+0x96/0xa8
 [<c02434bb>] pci_device_remove+0x1b/0x2c
 [<c029899b>] device_release_driver+0x4b/0x64
 [<c0298b04>] bus_remove_device+0x60/0xb8
 [<c0297f30>] device_del+0x70/0x90
 [<c0297f5d>] device_unregister+0xd/0x1a
 [<c0243be1>] pci_remove_bus_device+0x41/0x74
 [<c0243c39>] pci_remove_behind_bridge+0x25/0x4c
 [<c0326407>] cb_free+0x1f/0x44
 [<c032328d>] shutdown_socket+0x7d/0xf4
 [<c03235a5>] do_shutdown+0x5d/0x64
 [<c03235e5>] parse_events+0x39/0xd0
 [<c0328ad0>] yenta_bh+0x11c/0x128
 [<c03289b4>] yenta_bh+0x0/0x128
 [<c01349e6>] worker_thread+0x28a/0x430
 [<c013475c>] worker_thread+0x0/0x430
 [<c03289b4>] yenta_bh+0x0/0x128
 [<c011dacc>] default_wake_function+0x0/0x1c
 [<c011dacc>] default_wake_function+0x0/0x1c
 [<c0108211>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 0a 01 90 07 47 c0 ff 06 80 4e 04 08 85 f6 0f 84 23 01 
 <3>Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c011f8e8>] __might_sleep+0x54/0x5c
 [<c0220a91>] crypto_alg_lookup+0x21/0xd0
 [<c02218e9>] crypto_alg_mod_lookup+0xd/0x34
 [<c0220c5d>] crypto_alloc_tfm+0x11/0xc0
 [<c0406e00>] __ipv6_regen_rndid+0xa0/0x1f4
 [<c011cd1d>] wake_up_process+0xd/0x14
 [<c0406f82>] ipv6_regen_rndid+0x2e/0xc4
 [<c012ba5b>] run_timer_softirq+0x1c3/0x2d8
 [<c0406f54>] ipv6_regen_rndid+0x0/0xc4
 [<c0127441>] do_softirq+0x51/0xb0
 [<c010c3b1>] do_IRQ+0x2d1/0x2ec
 [<c0108034>] default_idle+0x0/0x34
 [<c0108034>] default_idle+0x0/0x34
 [<c010ab94>] common_interrupt+0x18/0x20
 [<c0108034>] default_idle+0x0/0x34
 [<c0108034>] default_idle+0x0/0x34
 [<c010805a>] default_idle+0x26/0x34
 [<c01080e9>] cpu_idle+0x35/0x44
 [<c0105000>] _stext+0x0/0xcc
 [<c01050c5>] _stext+0xc5/0xcc

__ipv6_regen_rndid(): too short regeneration interval; timer diabled for eth0.
---8<---

Thanks.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)


--7AUc2qLy4jB3hD7Z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="add-xircom-fix.patch.gz"
Content-Transfer-Encoding: base64

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
AAA=

--7AUc2qLy4jB3hD7Z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="add-xircom-pcidev.patch.gz"
Content-Transfer-Encoding: base64

H4sICEJYZz4CA2FkZC14aXJjb20tcGNpZGV2LnBhdGNoAI2OwQqCQBBAz/oVAx3N3HVZM0+S
LrWH1ZAwb0u4VgtiYQR9fqZBdUiay8zhzePZtg3nVh8d3ZT1TVVOrZvb3bmUWmp1nZ3gNbtK
gdi3ABTwIqA4oD64CBHTsiwYfsYNHwLUCfzAnQ+CMAQbu4ROPbD6PYcwNE2YqOqgmwo2EZc5
S+I0kzyWBc+iVBgGumNM1TcVs5xH7E3JgrgIS7ZddzjqY0fxbCmot3qyGOG/1CIWA05+Bmfd
xbc8TYZmj5gPKvpbHHMBAAA=

--7AUc2qLy4jB3hD7Z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="add-xircom-oopsfix.patch.gz"
Content-Transfer-Encoding: base64

H4sICNvoaT4CA2FkZC14aXJjb20tb29wc2ZpeC5wYXRjaACFj0FugzAQRdf2KWYVNQIDISIQ
okhcoKsewHKwFyM5JrIHlKjK3WsC6aKbrkZv/vyvP0IIsOjGe649TsaHPBiPyuZNWRXy1mPW
Z4PV7EsRfCoP0EC5b6u6LWooi2LPkyT5L+Cv+dBW5WLuOhC7Y1OnR0he8wBdx4FlYQw34zQ7
Q0yQK8nBmXRWvQnj1bBVXehXRC1JXayJ6tJkLiHpYlMuWLaUhDN8R4popt6qEOJiQ/SQb55v
nzHueeLAIZAi7AEdgZTokNbk94uv3cc0oN7yH3tqtCJRAQAA

--7AUc2qLy4jB3hD7Z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="add-cpufreq-userspace.patch.gz"
Content-Transfer-Encoding: base64

H4sICPjpZj4CA2FkZC1jcHVmcmVxLXVzZXJzcGFjZS5wYXRjaAClkctOwzAQRdfJV8yqSpWk
dVMeohEoC5BAomJBWSFkGWdSLPIwflQtX4/btAVES5HYeOTRnevrM3EcQylqO+/nSsxQ6T6X
tlD41rfa3STj2OO9psy9yYuFMVMAJ0CSERmMhmeQEDL0wzA8bPFz/Chpx7MM4uPBIDqFsC1Z
5oPnOQ9aiZoujR7d5QnOQTal4Iv4wvXTrYbNd2vYfKvhVu3UuH7qx56X40xwpFwhM0gLUSIE
G42oTdFzggg67qTMGEU1Z+7DU6rRaImYd1M//N3lsIGLWmHF5QKCjsulsDa0nV6ljtahI9Di
HZsi0EZZbmCNei3ttkZWBp0te/dI1bafXbLXtAWekBXwVfkELrTjWbMp5htUJN23DLJ3BeQr
VIVVM/s31J0uf4K6h0XV5LZEKq0JJtc393R8d/lwe/WN0wfZXvluGwMAAA==

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="add-nfip6-dupefunc.patch.gz"
Content-Transfer-Encoding: quoted-printable

=1F=8B=08=08=B4=E9f>=02=03add-nfip6-dupefunc.patch=00=ED=98mO=E38=10=80?7=
=BFb=B4'=AD=92=A6)yk=A0E =B8=A5=07=E8=F6
=EA=16=E9>=9Cd=A5=8D=D3X=84=B4J=1C=16=B4=BB=F7=DBo=EC=B4=A5=DB=A6'=B2=A0=D3=
-JT=E2=D8=1E=8F=1D{=9E=99	=86a@=CC=92=FC=C1=B0=DB=9D=B6=E7=1A=C9=8C=87y=1C=
=EF%=94=EF=B1=F9=BD'=1EB=16s=9Ab=D5=E3=C4=8F=DA=93=F6,=0E=1A=B6i:=86=F8u=C0=
vz=8E=D93=CD=B6=B9=BC@7-=D3Tt]=AF=AE}[=B3=EBli>9=01=C3=F6Z=D6>=E8Xxpr=A2=C0=
=E2"$wl,=B39;T=E0=1B=FE)=06K8=88=F9=08}=E0$
R5?=80=04=9F=F1QS=8C/=8A=B1=1C=9CR=9E=A7	=A8=A0.=BA=E1=E8=08=06=FD?G=17gCrq=
u=AD-=E4=BE~}=1A=B3=BA=CA=C6=0C=AFnF=97=83s=AD=CA=98=DF=86=A7=E7=7F=F4=07#=
=AD=C2=98=D3=9B=D1=85Vqm=FDO=D5=DFgp5=E8W=9D=E7=AC=FF	=DFE;T=8Co=8A=A1=C0^=
=13=86r=9B3=B0=80=85=C0#*=0E=0BX=06w>=9FD4=80=F1=A3lM=FDdJ[`=C2=0Ck=E9g=96Q=
h=EE)=90q=9F=B3	=B0=04m=8Bb=C1=151=9E=C8=C1jN=B0=C1=B1	=87;=96=B4`=AD=EA?=
=ACWqD=0B=A4]$=F74=E5=9A4=A9=FDn=0B-=CA;=C0=FB=9AE=C54=81#=C8n=C7=C6=B1x4`=
=CE=D3=C3U/=A7ws=EC6=A5=A1-=1B?G,=A6=A0~gsK=83=D3=E0=8B=A2o	=A2=F5=97	n=EEo=
=C6=D3|=B20=E6=D9\=CAC=13ob=F6=0D=D1=B3=FE=AF7=E7=D7=EA;)=EBG=10Q?=A0)0=A4=
=0D=F7o=96=C0_=C9;q(U]@=90=F1]>=C0u_=EE=03=A4=FAM=D5V=CF=B4=CA=9D@=B7p=02=
=DD=85=13=F8%=A0=A1=B0=8A=C5=CB=87=B3=14=CD=A2=05~:=CD=DA=ED=B6=86=024	XX;=
=85=FF=9DS@=F3m=82:z=9CSx=0F=E6=C3=07S=83=E3c=F0ds=C3l=18=C7=C0=A6=C9,=F5=
=C71=95'=7F=E0
V=F7=9D=B7=C7*=CAf=AFF+=CD=E6=E5=B4"R=F6=CBi=95=EA=B7U=DBv9=ADNA=AB=B3=A0=
=B5Q=07=EB:X=FFp=B0=96=0E=C0[:=80=C6=0E=F4=1B=FF=11=F4=8D=7F=C1}%#=DE=01=9B=
p}r5Ua=0ES=7F=BA=8Bf=DBy9=CD=85=FEm=DDn=A7=14g=D7=958cQ=9A=81=B3=A0f=FAga=
=9A=05/B=9A=05=15=89f=C16=D0]=81=B2~`=BF=BD=88.=B8z=B5=88=1E=8D=A3]>=A0=84=
=D3=CA>@=AA=DFTm=D7=F9w=9D=7F=D7=F9=F7=0F=D0*=DA
]=E5=D0=DA=AF=92=86=AF=CF=B2=3D=83=ED=95=B3[=84o=DB=AD=D9=FD=A9=D9]=C5c=11=
=88W=86=B0=08=C8=93Y=92=F1%
=D9-=19=E7a=08M=04=B4=85=A9q=03=BE=EBF=A3"=01=BDg=13=8C=F3=18=BD=8B=A0=DC=
=91A=D9]`=FE=B6=F2=E9=94=EF=82=B2=04=99=CAP=A6=BC=0CF=D7,=87=D1*`=B4j=18=EB=
=E4z=E3{=99N=B3=98=86=FC=15R=EC}K~3=9Bo/h=A7=BCr=C8f=C9$=CE=03=BA';=9F=E0=
=95=C1T=10L=B8Hv=B2vT=E6"=BC=9E=DB}=BE=8Bx=F6T=1B=D3=B8=DD^=C7=DA=F1=ED-Rn]=
=14=DD=E2=FF=1Fx=ADm=1Fn=B7=D4	MY=B4=96=02=F73=B4=C6f=9E=D14=F0=B9=AF=89m=
=D5=D1f?Dtr=0B=E8e=C0O=00=8F=87&=99=D8A=B4H]=D4=D0k=14^f=ED=14=D7=BC=CC=A1=
=A2?y=AC=CBkoDN?^=9E=0F=D4L=03U=15w=1DTB=FCXd=90!!=EA=FA*i=C2=D3G=CD=B0=D0=
=1A=DE=C3=DF=CF=10=13=86P8?=84=8D=90=DF=FB=C3A=FF#!=B8=D4=7F=00=EC"Iw=CE=1C=
=00=00
--7AUc2qLy4jB3hD7Z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="add-nfip6-noexp.patch.gz"
Content-Transfer-Encoding: base64

H4sICLzpZj4CA2FkZC1uZmlwNi1ub2V4cC5wYXRjaADNltFOgzAUhq/lKZp5M4PFFhjb0Bim
olucg8BM9IrAKEJEtkBnjE8vdFFnYMY5NiWkgab9z8n/nZ4UQgjiKJm/QFFoCYoMkykN5nF8
lBB6FM2eleIjiGJK0vxXoY4bChNhGvt7IkISLN4WEEW11VZFWUDvD+ARRojjeX599bKyjEvK
mgZg97AN+O6hAjSNA/tRMonnPgEnLOCnsMPi5OoOdb2YZEJ4+pPVLJdiKQf1O9Owxs7IcOz7
mzNjaB9z4Ma4uB3qznBwro9svdm4MoeNg8/5C90+twbmeGCMmo2B+ayAXh88uXQSLq/q3Y77
htVs9BI/dTNwHWXQfnW9KTh5jLJXV8smoeA9ESGcnxbb4Lqs/IxWw+qouLM5LCZflpaqaeFW
gSsfF7xyBj4JooSAvmGe3efDHlrX7P0o+Nj9jfV9b8n7tU0k2azaxG5empubyOS/SEsqQiqS
/qLki2RqrHndNndf9EHqPlQAW7haQ4ta6Je1Maoue8zKHm+NGcunRmiXVu9q99RCL1wFDePN
oTH5Cun2L1sV/petqpgLieuTdKWXNXSs5SjlCBW3AGapzCyVt3YMlrKq8TAsFLPdn4eUrkJY
xzUrpVXopD/qYHk2NSKzxhvT4t4A2aiUIBYLAAA=

--7AUc2qLy4jB3hD7Z--
