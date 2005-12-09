Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVLIRsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVLIRsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVLIRsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:48:52 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:54646 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964816AbVLIRsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:48:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Message-Id;
  b=cnD+0VpiMjEc8U+xzHEr29rFzqy3iFsRYVzgRu/Rmzk0SChyHJuLDIttUpajeduSOIq/fqKncOVixPWUehoCqybtuZsQwur3z9uPmag8tWjtjf3gVkfTAZNL+KHnuhPBSzjMmyjEen94E+oid2Lejqnw42fWWSyO9bW8S36i6J4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: LKML <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman" <greg@kroah.com>
Subject: 2.6.14.3 - sysfs duplicated dentry bug
Date: Fri, 9 Dec 2005 18:48:41 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6NcmDXOaXdtYzlM"
Message-Id: <200512091848.42297.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6NcmDXOaXdtYzlM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Q: Since when is a directory entry allowed to be duplicate?
A: Since Linux 2.6.14!

$ uname -r
2.6.14.3-bs2-mroute

The only sysfs-related change is the use of a custom DSDT, which is new to=
=20
this kernel.

$ ls -li  /sys/devices/system/
totale 0
425 drwxr-xr-x  3 root root 0  7 dic 03:57 acpi
 17 drwxr-xr-x  3 root root 0  7 dic 03:57 cpu
197 drwxr-xr-x  3 root root 0  7 dic 03:57 i8237
195 drwxr-xr-x  3 root root 0  7 dic 03:57 i8259
204 drwxr-xr-x  3 root root 0  7 dic 03:57 ioapic
242 drwxr-xr-x  3 root root 0  7 dic 03:57 irqrouter
202 drwxr-xr-x  3 root root 0  7 dic 03:57 lapic
421 drwxr-xr-x  3 root root 0  7 dic 03:57 lapic_nmi
199 drwxr-xr-x  3 root root 0  7 dic 03:57 machinecheck
193 drwxr-xr-x  3 root root 0  7 dic 03:57 timer
193 drwxr-xr-x  3 root root 0  7 dic 03:57 timer

$ ls -li  /sys/devices/system/ -d
16 drwxr-xr-x  12 root root 0  7 dic 03:57 /sys/devices/system/

=46rom the hard link count you can also verify (tested with find -noleaf, o=
utput=20
below) that=20
the duplicate "timer" dentry is not counted again in the hard link count.

(perfectly reproducible, it's not a race condition on "ls" time - and it=20
duplicates always the same dentry. I've not tested rebooting though).

lsmod output and .config attached. Additionally, "strace -v" output attache=
d=20
(SysfsRootBugreport.bz2) - the relevant line is the getdents call=20
on /sys/devices/system:

getdents(3, {{d_ino=3D16, d_off=3D1, d_reclen=3D24, d_name=3D"."} {d_ino=3D=
7, d_off=3D2,=20
d_reclen=3D24, d_name=3D".."} {d_ino=3D425, d_off=3D3, d_reclen=3D24, d_nam=
e=3D"acpi"}=20
{d_ino=3D421, d_off=3D4, d_reclen=3D32, d_name=3D"lapic_nmi"} {d_ino=3D242,=
 d_off=3D5,=20
d_reclen=3D32, d_name=3D"irqrouter"} {d_ino=3D204, d_off=3D6, d_reclen=3D32=
,=20
d_name=3D"ioapic"} {d_ino=3D202, d_off=3D7, d_reclen=3D32, d_name=3D"lapic"=
}=20
{d_ino=3D199, d_off=3D8, d_reclen=3D32, d_name=3D"machinecheck"} {d_ino=3D1=
97, d_off=3D9,=20
d_reclen=3D32, d_name=3D"i8237"} {d_ino=3D195, d_off=3D10, d_reclen=3D32,=20
d_name=3D"i8259"}

/*The dentry*/
{d_ino=3D193, d_off=3D11, d_reclen=3D32, d_name=3D"timer"}
/*Again*/
{d_ino=3D193, d_off=3D12, d_reclen=3D32, d_name=3D"timer"}

{d_ino=3D17, d_off=3D13, d_reclen=3D24, d_name=3D"cpu"}}, 4096) =3D 384

I have not tested if this bug is new to this kernel.

=46inally:

# find /sys/devices/system/ -noleaf
/sys/devices/system/
/sys/devices/system/acpi
/sys/devices/system/acpi/acpi0
/sys/devices/system/lapic_nmi
/sys/devices/system/lapic_nmi/lapic_nmi0
/sys/devices/system/irqrouter
/sys/devices/system/irqrouter/irqrouter0
/sys/devices/system/ioapic
/sys/devices/system/ioapic/ioapic0
/sys/devices/system/lapic
/sys/devices/system/lapic/lapic0
/sys/devices/system/machinecheck
/sys/devices/system/machinecheck/machinecheck0
/sys/devices/system/machinecheck/machinecheck0/check_interval
/sys/devices/system/machinecheck/machinecheck0/tolerant
/sys/devices/system/machinecheck/machinecheck0/bank4ctl
/sys/devices/system/machinecheck/machinecheck0/bank3ctl
/sys/devices/system/machinecheck/machinecheck0/bank2ctl
/sys/devices/system/machinecheck/machinecheck0/bank1ctl
/sys/devices/system/machinecheck/machinecheck0/bank0ctl
/sys/devices/system/i8237
/sys/devices/system/i8237/i82370
/sys/devices/system/i8259
/sys/devices/system/i8259/i82590
/sys/devices/system/timer
/sys/devices/system/timer
/sys/devices/system/cpu
/sys/devices/system/cpu/cpu0
/sys/devices/system/cpu/cpu0/cpufreq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq

(and -noleaf is indeed needed, because otherwise find does not recurse inbt=
o=20
cpu0/)
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_6NcmDXOaXdtYzlM
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod"

Module                  Size  Used by
sd_mod                 18200  0 
cifs                  221852  1 
nls_iso8859_1           5504  0 
nls_cp437               7232  0 
isofs                  37964  0 
zlib_inflate           17728  1 isofs
cpufreq_powersave       2176  0 
af_packet              25100  2 
cpufreq_ondemand        7532  1 
ipt_REJECT              5888  2 
ipt_LOG                 7168  1 
ipt_length              2048  2 
ipt_state               2304  5 
iptable_filter          3584  1 
ipt_MASQUERADE          4032  3 
iptable_nat             9028  1 
ip_nat                 21628  2 ipt_MASQUERADE,iptable_nat
ip_conntrack           56080  4 ipt_state,ipt_MASQUERADE,iptable_nat,ip_nat
ipt_TOS                 2816  6 
ipt_MARK                3008  2 
ipt_multiport           2944  6 
iptable_mangle          3392  1 
ip_tables              22784  11 ipt_REJECT,ipt_LOG,ipt_length,ipt_state,iptable_filter,ipt_MASQUERADE,iptable_nat,ipt_TOS,ipt_MARK,ipt_multiport,iptable_mangle
uhci_hcd               34208  0 
parport_pc             38440  0 
parport                42252  1 parport_pc
yenta_socket           27724  0 
rsrc_nonstatic         13312  1 yenta_socket
pcmcia_core            45212  2 yenta_socket,rsrc_nonstatic
i810_audio             39320  0 
ac97_codec             21720  1 i810_audio
ehci_hcd               34056  0 
usb_storage            46916  0 
scsi_mod              113328  2 sd_mod,usb_storage
ohci_hcd               22532  0 
snd_pcm_oss            55904  0 
snd_mixer_oss          19008  1 snd_pcm_oss
snd_seq_oss            36224  0 
snd_seq_midi_event      8704  1 snd_seq_oss
snd_seq                59776  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          9808  2 snd_seq_oss,snd_seq
snd_intel8x0           37472  5 
snd_ac97_codec        107416  1 snd_intel8x0
snd_ac97_bus            2880  1 snd_ac97_codec
snd_pcm               102796  5 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              27400  4 snd_seq,snd_pcm
snd_page_alloc         11984  2 snd_intel8x0,snd_pcm
nls_iso8859_15          6144  2 
nls_cp850               6400  1 
vfat                   15296  1 
fat                    55472  1 vfat

--Boundary-00=_6NcmDXOaXdtYzlM
Content-Type: application/x-bzip2;
  name="config-2.6.14.3-bs2-mroute.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-2.6.14.3-bs2-mroute.bz2"

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
bkARf/F3JFOFCQninCqg

--Boundary-00=_6NcmDXOaXdtYzlM
Content-Type: application/x-bzip2;
  name="SysfsRootBugReport.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="SysfsRootBugReport.bz2"

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
/i7kinChIRdB2ug=

--Boundary-00=_6NcmDXOaXdtYzlM--


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
