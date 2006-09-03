Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWICSN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWICSN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 14:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWICSN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 14:13:27 -0400
Received: from mout0.freenet.de ([194.97.50.131]:38610 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751577AbWICSN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 14:13:26 -0400
Date: Sun, 03 Sep 2006 20:20:43 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Content-Type: multipart/mixed; boundary=----------0eH4UwucgQn9AZZoRrhJ2R
MIME-Version: 1.0
Message-ID: <op.tfbektu4iudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------0eH4UwucgQn9AZZoRrhJ2R
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: Quoted-Printable

Hello,

this is a patch for the packet writing driver pktcdvd.
It adds a sysfs interface to the driver and a bio write
queue "congestion" handling.

The patch modifies following files of the Linux 2.6.17.11
source tree:
  Documentation/cdrom/packet-writing.txt
  include/linux/pktcdvd.h
  drivers/block/pktcdvd.c
  drivers/block/Kconfig
  block/genhd.c

(genhd.c must be changed to export the block_subsys
symbol)

The bio write queue changes are in pktcdvd.c in functions:
  pkt_make_request()
  pkt_bio_finished()

Any comments and improvements are welcomed ;)


Why this patch?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This driver uses an internal bio write queue to store
write requests from the block layer, passed to the driver
over its own make_request function.
I am using Linux 2.6.17 on an Athlon 64 X2, 2G RAM and while
writing huge files (>200M) to a DVDRAM using the pktcdvd driver,
the bio write queue raised >200000 entries! This led to
kernel out of memory Oops! e.g.:

----------------------------------------------------------
Aug 14 17:42:26 master vmunix: pktcdvd: 4473408kB available on disc
Aug 14 17:42:54 master vmunix: pktcdvd: write speed 4155kB/s
Aug 14 17:54:24 master vmunix: oom-killer: gfp_mask=3D0xd0, order=3D1
Aug 14 17:54:24 master vmunix:  <c014346f> out_of_memory+0x12f/0x150   =

<c01452d0> __alloc_pages+0x280/0x2e0
Aug 14 17:54:24 master vmunix:  <c015a52a> cache_alloc_refill+0x2ea/0x50=
0   =

<c015a7a1> __kmalloc+0x61/0x70
Aug 14 17:54:24 master vmunix:  <c039c0b3> __alloc_skb+0x53/0x110   =

<c03985b6> sock_alloc_send_skb+0x176/0x1c0
Aug 14 17:54:24 master vmunix:  <c0399c5b> sock_def_readable+0x7b/0x80  =
 =

<c041262b> unix_stream_sendmsg+0x1cb/0x310
Aug 14 17:54:24 master vmunix:  <c039502b> do_sock_write+0xab/0xc0   =

<c0395720> sock_aio_write+0x80/0x90
Aug 14 17:54:24 master vmunix:  <c011a609> __wake_up_common+0x39/0x60   =

<c015d984> do_sync_write+0xc4/0x100
Aug 14 17:54:47 master vmunix: printk: 10 messages suppressed.
Aug 14 17:54:47 master vmunix: oom-killer: gfp_mask=3D0xd0, order=3D0
Aug 14 17:54:47 master vmunix:  <c014346f> out_of_memory+0x12f/0x150   =

<c01452d0> __alloc_pages+0x280/0x2e0
Aug 14 17:54:47 master vmunix:  <c0258de2> __next_cpu+0x12/0x30   =

<c015a52a> cache_alloc_refill+0x2ea/0x500
Aug 14 17:54:47 master vmunix:  <c015a23a> kmem_cache_alloc+0x4a/0x50   =

<c03987ea> sk_alloc+0x2a/0x150
Aug 14 17:54:47 master vmunix:  <c03e3f8d> inet_create+0xed/0x320   =

<c03950a2> sock_alloc_inode+0x12/0x70
Aug 14 17:54:47 master vmunix:  <c017790e> alloc_inode+0xce/0x180   =

<c03966f3> __sock_create+0x123/0x2f0
Aug 14 17:54:49 master vmunix: Total swap =3D 2152668kB
Aug 14 17:54:49 master vmunix: Free swap:       2152436kB
Aug 14 17:54:49 master vmunix: 524272 pages of RAM
Aug 14 17:54:49 master vmunix: 294896 pages of HIGHMEM
Aug 14 17:54:49 master vmunix: 5767 reserved pages
Aug 14 17:54:49 master vmunix: 238277 pages shared
Aug 14 17:54:49 master vmunix: 35 pages swap cached
Aug 14 17:54:49 master vmunix: 47682 pages dirty
Aug 14 17:54:49 master vmunix: 157861 pages writeback
Aug 14 17:54:49 master vmunix: 17359 pages mapped
Aug 14 17:54:49 master vmunix: 23835 pages slab
Aug 14 17:54:49 master vmunix: 176 pages pagetables
Aug 14 17:54:59 master vmunix:   <c0145355> __get_free_pages+0x25/0x40
Aug 14 17:55:19 master vmunix: 294896 pages of HIGHM<6>5767 reserved pag=
es
------------------------------------------------------------

It don't know exactly what is wrong in the kernel, but
it seems it must be something with the kernels memory handling.

To be able to use the pktcdvd driver now, i created this patch.
It simply limits the size of the bio write queue of the driver
to save kernel memory. Does not cure the "kernel bug", but the
symptom ;)
If the number of bio write requests would raise the bio
queue size over a high limit (congestion on), the
make_request function waits till the worker thread has
lowered the queue size below the "congestion off" mark.
The wait is similar to the wait in get_request_wait(),
called by the "normal" request function __make_request().

Peter Osterlund suggested to use the pair
  clear_queue_congested()
  blk_congestion_wait()
here. But i am not sure if this is the right way to do
it.


Also there is now a sysfs interface for the driver and the
procfs interface can be switched of by a kernel config
parameter.

Here are more informations about the new features of the driver,
that are added to packet-writing.txt by this patch:


Using the pktcdvd sysfs interface
---------------------------------

The pktcdvd module has a sysfs interface and can be controlled
by the tool "pktcdvd" that uses sysfs.

"pktcdvd" works similar to "pktsetup", e.g.:

	# pktcdvd -a dev_name /dev/hdc
	# mkudffs /dev/pktcdvd/dev_name
	# mount -t udf -o rw,noatime /dev/pktcdvd/dev_name /dvdram
	# cp files /dvdram
	# umount /dvdram
	# pktcdvd -r dev_name


The pktcdvd module exports these files in the sysfs:
( <pktdevname> is one of pktcdvd0..pktcdvd7 )
( <devid> is in format  major:minor )

/sys/block/pktcdvd/
     add               (w)  Write a block device id to create a
                            new pktcdvd device and map it the
                            block device.

     remove            (w)  Write the pktcdvd device id or the
                            mapped block device id to it, to
                            remove the pktcdvd device.

     device_map        (r)  Shows the device mapping in format:
                            <pktdevname> <pktdevid> <blkdevid>

     packet_buffers    (rw) Number of concurrent packets per
                            pktcdvd device. Used for new created
                            devices.
	=


/sys/block/pktcdvd/<pktdevname>/packet/
     stat              (r)  Show device status.

     reset_stat        (w)  Write any value to it to reset some
                            pktcdvd device stat values, like
                            bytes read/written.

     write_congestion_off (rw) If bio write queue size is below
                               this mark, accept new bio requests
                               from the block layer.

     write_congestion_on  (rw) If bio write queue size is higher
                               as this mark, do no longer accept
                               bio write requests from the block
                               layer and wait till the pktcdvd
                               device has processed enough bio's
                               so that bio write queue size is
                               below congestion off mark.

     mapped_to              Symbolic link to mapped block device
                            in the sysfs tree.




To use the pktcdvd sysfs interface directly, you can do:

	# create a new pktcdvd device mapped to /dev/hdc
	echo "22:0" >/sys/block/pktcdvd/add
	cat /sys/block/pktcdvd/device_map
	# assuming device pktcdvd0 was created, look at stat's
	cat /sys/block/pktcdvd/pktcdvd0/packet/stat
	# print the device id of the mapped block device
	cat /sys/block/pktcdvd/pktcdvd0/packet/mapped_to/dev
	# similar to
	fgrep pktcdvd0 /sys/block/pktcdvd/device_map
	# remove device, using pktcdvd0 device id   253:0
	echo "253:0" >/sys/block/pktcdvd/remove
	# same as using the mapped block device id  22:0
	echo "22:0" >/sys/block/pktcdvd/remove


Bio write queue congestion marks
--------------------------------
The pktcdvd driver allows now to adjust the behaviour of the
internal bio write queue.
This can be done with the two write_congestion_[on|off] marks.
The driver does only accept up to write_congestion_on bio
write request from the i/o block layer, and waits till the
requests are processed by the mapped block device and
the queue size is below the write_congestion_off mark.
In previous versions of pktcdvd, the driver accepted all
incoming bio write request. This led sometimes to kernel
out of memory oops (maybe some bugs in the linux kernel ;)
CAUTION: use this options only if you know what you do!
The default settings for the congestion marks should be ok
for everyone.
	=



-Thomas Maier

------------0eH4UwucgQn9AZZoRrhJ2R
Content-Disposition: attachment; filename=pktcdvd-patch-2.6.17.11.bz2
Content-Type: application/bzip2; name=pktcdvd-patch-2.6.17.11.bz2
Content-Transfer-Encoding: Base64

QlpoOTFBWSZTWc3IXW0AOof/gH56IJZ7/////////r////9gSDwdUUKiorci1W2Q
sLGi3ubvvV77332++N5SQ9BqVB7ZI17sPe7gbmeG64B4SKO8vLu80O8Vmp6Ka7PI
rrEQm5ehunXEidMCSQ7YaZnYuzdjkFFWxzbthh3B1suc3du711AdPOY2GVNLrdOg
ubbVKrbZtqyxtDXRxdCjdhXR00mGIWhi7tKTANrYO+scJZ7mjQUgqptm0DTRAjIE
DITIAaU/UmaE8ojJmo2gEZA00BoGIASmghAQJoEyGimaEwEp7SamemqZPU2hpGQH
kIB5TTaQNPJVKmmBDAmJgTAAmAgyaaYAJgCGBGAmQSaSJBCaE1TzSj0/RE9TJ6Ue
UZG2qeQgNGg0AMnogeoGjQIkoBGhpNAExDQaARG1NTeiGpkZkZJpjSaAaAyaYKiS
ICAE0TTInqMlPyp7JMRGygeUeo09TTRo0aDQ0AGh4+cZEixYojBEjE960UUjD0EG
UCSe9pnxghUUVVVVjq1ba8MNDisV02LUKn+rU+pqr8pdoswVBRYaGqgcxC1qoiuj
DMX8tmKMma55l0IZU+cNkwMd8zL7DW2GpqVQBigAExhI5VrmUlXCXGWLmXBKqKsF
K9E06tqqiLFmqIjDEkQukjdFliTKmI6IpjWoCqlVqqImWUMhQaFVRGUblKhgIZS4
tC1VtCotEUjRLD8bIdB+0mkGDIqxEEWKim3hiZExRYuAEISwIIAxiMEla3LATJid
p+Y2E3ED5z6DA/Ih3MD1hwdFVVVVy1VVVYpKwEs6sxzt0U0CYwotLUZ/FRfwL/Id
Pp/IfTlxzxcjsQ/zPOflMDu71s4DCSUtxcDLiqqrRCy2hYtisYlmTWMoAAAAATTV
trNBG0WWSmVUpRstcjChBTBtsrJmNMYRKQsimI22ULcbRsQiAAAEqy5BLLLYAxGy
XMWywXAjFrbFcoWMVQAByuCUisTBUzEuUwhmJVjFc7hI0HQUJSWCSykkQIjWKjbI
ecTMpdXFYTExAyXBsbhMrQzKQMgwpGGQZRbQoxRttMlMLcyZmKpCWlMhS0wuDkcp
gyMQjjVxiti1QALggFhI0tQrcLBcglp4sxFw1EtYGZCyYwuYpCgoFLEojEFT6R6d
H+z4bV1vFxR0EUPhOIzFvjjpbbzymfzUta/faYt+QiGj+v/OAjD+iIf17Esk1Ixb
WNIjrPZDngZdHxJVnrN4R4qk2emcHvXBCTdUM5mzfII/H87P9wwltJOJFQwun/Oq
CBgbyNk3sFmqsqIpJOL5+HqelUVrMHuQeWvP90gw4oo18Aw1EAnyRURQezcNf5dP
fk851pcCQFIBApvg8c70LKjFdCqqn2oiDJKIgNBuxNmqGIU/h8lCb3PUKEeKgh3/
R+fw5b4ROKIlELMsxKM7sOewugK/Adh3+FcIcuXM2P+0NCPe4ziaTVxnBAk3bQ9M
Fgs15mdTloF2k4abSXi1Zg6oVHfdEiQIJdnTPYUMGBHBMBqr75d/z9stsdWFb7w4
N96r/woaueMTpEChIeVXz7nQD7SE4U++/qjc7N6+XX6flBYLFUURRDlJ5fTdXPb9
w+nNSLXOjhDAkAqdjHkM54UJ/r+m0SzuP4cfCqY4WHPpzc9E+r9vmOH+NOevsvGg
np5d+aB9jhaGhx0cvTsw5lacMnAkWKKVnezQ71MNN0XSUlpZjOSBsYcM1xbuX4Lm
bEHGoL1437+zZ01m75snMRYKQ3BK8i2bOOaW+Gp3dpeQwixVFIej8X1+uzdUY9cv
MU5GExfOcK0L92Q86vEP8qdBjd8hfqWdsXRZFFEUEOK+ZvWz0BIPSd2HXWbtDhyk
ek9+41SgvsHjl5fpumNoFY+nyg8rovg0/GSKGR1rk4kcsNjAXQV1iqRxB1nWHRGk
5tmwwYXeLruA8kFiVL4uWMeGaJHOf0x6+ouYV0D2yQkD3YQ6ZoM2jCpIXKiT31sj
FLykC4AlKj9r/1SOjyxnd/f7NpuiNR0W2iysbdLIiJceJl5JUTGgjLlmdnq4hDJA
6Pp8h1elM+g+b5OQpza7+a4nVNWiObpo98enmp5+Q8Eok54Zh22/pbnM41DaaaCb
Zk1asUtq6l4EZvH783haE4Httv6imAtKEkglKYFGW1lVrgijBwVzJrRWeV2x4stt
VMpwzjNb0UmmS7tR1Vxu7oYbSwQFAWbt0JpUQUcOLjm94LILAWKCrFFFCPBRJ0FC
MTRM9Ql08snvf39AUZ/a98/A4YCWYMyhWCgp0iEOjMYgYnr61tu1KXOuLu4oO1HO
/fblnWrLK81S34eGw3RRhEX6V75QeslCOcFVpgIILFkkFSElOZeScCshIqJJGH8J
q6gJ77Hz8j3r6bvgJE6Z1MCpcP0nsgZmiYsfH4LFqLA6Yt1H8RH2MKIZymQluVSb
SthloLmN8qBQKdYHYCB9QfgEGdO79ov9YEynxcUSascKmy3jkT2om7Y/q/gafFeb
DF8H/204JjR5Jym0NkAkIERoopjE96i5nLZof9vI/ZXuvtbp9qlU2eMmJ0+/01Hw
6q2EoiFEJG2F0HSKcm9vLA5g+Yz+3bsDUIjCeAhf+TAoYL6cmAlspDMzAwlbWJjI
RHKZbGlsaP0xyTRutH3bO8X8NJGevKVbr8se8vHzWraIKEmuV/c1VwvLN1sl2c4U
C4SlgqG207DknM18+p9xkxgaG+YcuEBTUzeZ5uB1kpuzDgsknwLHyMNkdn4vNXI4
v86P9nsp9nRifyH4fUOMYF6t8UXM9nRRppQbwto8w94Fh2BwgPMXH4wOkipzUahh
JBhE6fVLaTwGhsTJTX3Utz0fYpzvi+sa7W/Jx7iYd59DF+F/xEytVQ8jhYWnGScJ
zDfUjIsVYKKMixVRgwNfy/Gb7TfRD19OwVZSn9P3jW/UQTuTCoMIDaiW++fVaKeu
4C0fOPeuGjmvJbig6ReHDkQhNoGn3wMx7miIbIoc1LGgxqfgI9lkk1H1Fiza7rAG
f3a5Y/U9v8RYc5iwsPKqd89DDGMJbtfNJuIbt2z8RRQB7QuqEwmYX+AcICV4YPsr
zFSpZwcMBznrboIk6lVjgBsI/gvuMJdvQcMCDlkC5wbCCSSDgEsuvJddCMkXEzo/
h6hpEwjQdhqDBAovAsFBDOqmHIjwoDDHFyqrhkOOzx8PT4eJHp9kPCs4vgvjGCvg
5nN3CzMLtusDDkh9vKBplDzOEMejnCsBeRM5/gY+ptfnh+QfYhuR+LItsiqfef0j
SSuw+2AMH7z+LXQv8Z+Yhsxw95malGWmoUj7WHc+vOx5AYLWDvQmhi3595OB/rx2
NkG4jtc4EEIKk2gIaB0w0jI2dyUhSkugpr2H2lqEZndWnM8Z0c3o09Wt+cw2WbU+
ppObo6HM41BBcIbtWmY1v6OvExLvp2dXDBYb2/yyP1/hUkDno9QGZ10Ox+bnIMYt
d89jMxcfNf/T4uPOTX23g8Poz0rsMd2LwXgXYF2aMXo1Jrj/3R+aD7bGjN8vbQat
1cceobbtYg05594iZV+DiOLZKzQSB/5Hbf1dC5PAuUbW68TxExufohLMkbIytYJH
JP0CdIa4CIwyPKU8hcSL1v+vF6l9AFZM9gyDlEFgqs5Ku6xRn52NBEqXL5n64Lob
Q0DMyNiG3EBIVlPAWe3dqpx4kqAOTGGDhURgARzsTmiJaLh7mAaveL86MMem6QsC
lRbIUlUDNo6gtxGoAiGMk6UmC/NdeInc+hzjDlrF6KVHNFThHD1F/3k3SyT/Dlne
ae0VUCACwH0XiTLv5r+StF56MOANetVfryo8fUgGn9dCGMvEbQ745xk5mSRh35Vs
RJLks2r3CA+j4p9i8fXmQYMH6rm+5RR+ODAV+wc+9SGeSzL+OfLC5BfFHsLT6GVE
NoUY8GtYa1jNk1opeZZ2iw5RCH83jI19P6AvvmzgQMe6EIIBr/DOVc69oSz9Lm3T
NrEJ0znmVmA95LB0TWLgbGkI8E7MKQqItEIuCaQMNZXAyOBnecktI3TunxeUQq3D
S+Are8FNXf5xy6Lu4X2CvICYzovsbnur3xy2BXPshdHkkeUKUCTNvtapRKHJ8jNw
ct4/cWLnI18tfs/nSSSSckNtDgDfA3A624ltjs28dDXU1lJIbtK2s4aEUJ8JiNw4
XIKc3HnreEw0qFuwn0s/WPNl9wfrAiL6wWyn6A+ArjWB3DKdiYkoo5iIbbITK4Af
IeOnDIsYO3xsfEQ5sH4i3sl3BE8uDxxtHCYN3RcvYQq8UT77XlsNg3tlJRQQOH4z
6iTJuHdc8Pt7XkcYeBwHTWbc0OpjoZ9LGnQEbGQm7WK8hqCxfj5whRUBkE+QgNeu
q/NTT0kc2aQ0NJOboocgTAaU8J9R8Eg4hILtRiF6FIzkeLAOHU6FDlyosRNF4wqi
Rbm5RPt5zoiu4KOn11siQ0UMDqKnrwllCqqpECDODz9Klkden0xcL9p1nFt4T0WB
CDt8rDOjJx3NMjKPMIyk9xkUGZrhriMjG1zRUO6WhA9nYyTg7uJN6zodlszBnnof
/NYPA2NshygVb9II0Q5pBpkYLM1jUppBB6s3bBa+DST2uSZnI041+CPnO983Vze2
9vNjueFRs73yKpbSvhL7jiK1e04G5vGEWKZY2EqxLIZxrW8DIxPmcDtDtjhYlZjt
NxDRMBgtBQKJKigw5dO+qxdcRGCmwRvAvVwcckcy9toJT43yCeGmdpXLwz1vvmXr
O84U65mZXr6VpY9px5W30c01jQ3iqNbI0I5f5PYLlziY2iD5hW0yxFvNzgS6Wbh0
Nez+KTovayfTzxLZCS6ej6l7C7BiWuhX3C3hIe/6x5WMr7tJB6nTlHsALbRXviLB
e/NyMzLyuQOcWRseB6tTrg/NhuZXgR4CN9nahHsRaJGOIlPV4ftPp87ngrvQQvLC
uG+uR8RrLHlKCjgncmlEg6SoMiTdHXG7bEtRsXa7S1r6dP3HqcXVxhlnxzr18x9t
qllVKVVE4+Lntx7nxn9OJGOfb4zfbyU2s1hf9F88OxhNxgSmAlNdM0pl8H+shnp8
9FfSYsxKKQzMSas59Fvzu7wSHYyBQgD47+NDAflYFFCDCfiCPr0V9CqxEbYFVoxE
WRjJUGltaLRQtKsFUnvnpSVPsSmYdwmrAROh+uUImcSCmApuXBuE2YeEASHZ/k07
WZI3kSxhVKZbJKWVQVRgQiQgyW1X7ijDq7+IvNxFPvkFfl/UWfcT8n1czSyrFVxK
Otkvznx/SvFd5G+77+ZWKZgor2DcD0eHmmb7C5njtNm//IOvAzNLu2jxZ/L3xEOU
L+kGZM1g4GpWZ1MaHxiJ1rPiLM5sxqYRyLCICCBxzuPpOY4ZDfwwfN54N7AcNROI
hhvAggbpaA7TxdgwGxq5WGvZS2XQCfUI1ZhlcR9yG5ZdOrrQg9Yg3EUX1MyY7g2H
LW7ujRxCmoyZ4PIdhnCnPacRCHs2om703OWucTIzIMA9fV/64nkWLFmbffvklmO0
NO9uoOx+U8O/sBDsPLJldbRQirGXrEI97tc/d0/d7qA1j1Xy7Opg3oDYYDOCej06
WsBl31D9SvFTgoeOqMPQ6cRxqjKf24Nwf7dsX84/D6emUT8vsKPx9f0HR3C1rl23
4cHzpSrky2kVrt23l427aSw2tt2a5w0rK7TVpZ47U1b6gRF/7hkCP5Ilg9tEHQkB
ATR45xeR+eYVMtduL3CSqM7Yxp3x5OhatLnmTJEu8ILE+eZna5oabTGLxY2nKTz8
j1EbfUfSZl4HPLBc3i0s6kOJw9P1ueOIFjXRTERamWSxxcHgh42nYXu5Bof4zDvD
GsNSrSX9coRm07JRN8tEcMeSVcDETNbUoqkNx2aLqPhPqzNRsNMuPJg/RmIyavE6
fGOGTnuvGJFTcnM4cLCPki7yHuOC2TddbvqzsTA69pVmRhcnOBs9/DYm9VaZbuzt
3c549euuJy61XOrS/PnbaVbFzrHpVrwravQTKGl2bS2q6tb8cNTnAk1uZJaKsM5d
z6mGHLPMzuTUa0nqu0m4B6dCtqzZUD3LSWpXurjmqfvW+luSkwM85VmIhZJcLrY2
01iOiG+26MRUue/OMc97fMB6hxH9pmPeH7GESEEiRISLBYDCIjFVBGIgjFgMUEYg
d7YCsW2UQZQQKxGKRgxFVXQEID8UQIxQe2wEoD5YAyKR8zStVi4VhwM0ukhj9LDL
JH6iJJFsAtSSVH3RiJKTs/fU1HzKSbwS4i0j6iAnJ30qjynn6e2dNTwTsIY3hd33
XDt4dm0VViFT+33bVoOfziIqd31SdXAwuVGhXOSxE2fGie1OO/D7dVVVVVFVVVVV
VVVSSEklpdcubtw4DOWXNJGSM4/abX4EBofGQa3DiaHwO3TRNtSHVWfjgE5TNLnI
5dm9/6wfY00gkTRhrs1ZDeJbwH36br9GASBtF4SSi6YYjKQ2C2O3R6MOIah6Nx9D
kcLXG6H+4ucD6HNLDnFG88eFp5Bbx2CYZy340JDgMdDyg2zSKNjBl8oV0OFbJdHD
3DHI3DQyZuJf6cjLncuEAvaT6vzknX9mv1dp+z9v+n+S0fXdQlilJSiP+YsqeXqK
xVyqtd8WYZVgFTAxut/OZ+nd9PrQAGMU9i+2yvcECkqq2SYWximRjZjojyRsPrV9
H2/yqqqqqq+TYn5qT8gfET6IkXytp9JSH4HYxJ8lLPwODTVirqWS2FZR5yh9ASLB
L4XBATuLwxI+RLVbiKo4VGQqSLFdsJ7PyhmekztbozWgGfomMMQwNvf51vnbNZ6r
HzRg+WWcq4q4zL/hHZnnBSy0zeH+RPNVCzjLLLS+BGUPkLIuCE+j8kl3o8s7PR12
p3gnhBO8E3+UHUG4D1sOg0IMj4yE1EQH1+knsl01F3Iz7/fiMd1VjQJx8iIHxRsz
oCyw3LsL2mPReBSkIsCwo2JD3rzfV5/42qB/h+iuj/SViTbxSeaxUOJXQT2DEPbi
lnz2qCIOm2IYq2wEUghzO3wnjNhR9Fx7Ow+Wjyh6k+B+3DA6h9GAUIWPkGBd7OMK
D3GAFjrDzFgYGXlDqxtDvMx70+Tw6GxMBh7oG0gVHQNHZRu7gx2untwtxeyH560s
SFvyeUo908hDgD0HpMiwWGe58zx7Nl28phkILBPF48JfhVF4mMu+MSgjBLKLD2iU
iYXGGgmpwPMJMvRgXGVIEpxgYCRVf5hbyBBxBEZmb5yx86SY9yP0Id3A4a24OI4c
/9DlbAn6zHJ9mu14wTPSwI3lJsJIuVVkX2YAlvS+GeunwcZ0RVttl9jr6KfnXmnr
xxK9Vb9svELu5HXu5TobgxTDXBzgDtuMcJXFsRX3kwGeR2Q1qd7ZkUJaJlZw5njm
z8jk25jZmLcoXJy6nubyu1pZbLFh+UBMJiBHVULRWnJS5SLBLRcgW+Fa0vqtib6G
GuEJCYNgqfjVBozQRW8VBXmQWJGV0DE1bbwW21trGbsUmNFqczdjMKRsKDfLjAx6
gYwanK1Z8BO2pnfVJc2P8A9fAKTaorOTHNxmMlaC/Gq55MdkYEiqje7PkxAcb31W
OLurrBmCyFLKBAsBKp9To2NN1GjYrkQWDl9/Z3b4k7/P+Hxt6OaryX/5LW59ia3t
fFPbTSNMVmr1r9/I9ZIH2js38giEH1EorKwN58R8w4lp6Q8/u2+OSdb5kniEm3oN
tUVG4moj5xyCgkg/IcCRoCBFECi3sK9tTLT73QIB0Pc2DzkcZvi5OopNtjD5SEEy
M0BS+XZDHnk2wiuCj6wbsQt5zGMG5l+B+B6SMz8zSKJpoFZSVEtmLIBA/N8SiopE
jEbJzdMsUcQOyOZ7h2lSmvbma6j2S4R1Fx4uQmz2TOe2MRoJjxTGng9hYTZrdRPQ
e88vkeVx8crkt9yZmSayajP06dIopWe53LgVKbytpnI3g/4cClrKsoe3O0HuRkoR
4eyosgz1Thgboo5X0bcWj69T21QvN4pnbzl2FSQ3PwIyIUgYbV6SmBAEDl1S3VvA
zmlFp0jqOt0GCoOBcd0VeQBAoPsPkzvQQ1P24VBgSQoc26g9HByJuKDKpU2YYucE
r1dgZIHtUKidpiUJHMIvzFh19iLDqkqaKpCxznqpHQRCLldX9c4g0QzJc1ON5e1G
W3vs0e0pvVwLzMr1I17nOXpjppnY4I4IaVzQ/pJzn4UziRqvLnegsJhJ7bwgH4wi
+SKnw0oR/jLIqfMwSEFP8KcbP6KmpBYpV/WxjdUw2VMbqYqS18YsOFaWSJtrEqtW
JwUN6Ci0hZBL26SlfV352CJ9Kc4QTuqt1Bc+2fPshyJ3EU5cLjOGyBwBJIJeW/pI
WAjaJ9SrETtAvD2Nh2H2/SvzgB2r/AIND7Q+xWH2L8iFGTiGAV7jWFKakIHvWi/B
W25OL0hR+YF/Kn+x859f+romwc4unlAgZgcT5cj69bJpE3LYC2ms5FtDDf3xF2sk
qvOSVOTo8ZLJQVN0NjkwnF+RPAsNIBBguw2p4Hau/UdockRMjy6BCSLZa9jb5nU6
nP1viNR/qekcPcY7T2xzOfd3Im7lIyec3hhOrgd7/psmpp5+MNPInUWdCdT+tLs+
rsZ2ecp2dpPwDwbDaPcpaWTnnz8TJt5OKw4m/1n9TGWyyObpFOHJxdR9uImxi5B0
h0DyY+JgSIR5KL83YOZtDYDeajVcFCuK29XEmhYDE1Ew1RDDUNyWFsD8PJfiTdCd
ixek61yG00xzAobENRbIXHCjKT50wUwxt9CbjaNji7Lr2zFNSd0sfSpwa9tVmu0v
l5PFNTJMe8/U2OQRO0vDoFd20oHkH9zvHHIiNF3MZFptPubV5nBFiw2FJqFOJDpg
dBaeMsOk4g2AzaaJz2ABec6o0OfiTDiLuTbZIJqLAenbIq3THvKyWJqRmQ8vMPA9
9cp0nhGPO5Y0cDmfhd7HAn1/DZ6B8Z0TrJOXzlZ5uI7jlcgRIcUzenjRysblnAMB
Qx9Z6g8X1vHj+yLDI6rtrWZldH1R7Go9G5kntjgcmkpKSw27sa2TYsaLkmRIr534
WilwWt6YxbQNuKHkLkOoh2KWjxgGo6x7PE2IZuIlwdhQJa4wYy1PItwh23A+JwtM
jDyyQu1UuevUGo3ocgWlKeEh4yCUwDkDnblbAC2KnPY+Ww6AXqXNLlMMg157jxgb
A19oQ/TDxGBgeE60KOmB3GmY6GqbAoK5SinpegROrYq7ADgJapmZsIqY2pHb3b/i
q2Tk39G/00YrSxe6PJ2fDsNKcQ4TvnE+tum0sssbPPTUkocWmnEq2mruGN4GS8pA
hH15m0gLc55ScVyWmxx2q13K2lLtDea7UbQ0oGw19R165C8yeCd2Tm7Sxtvonc6k
709XfDA05O+HVO8w4Jh4SlJeinBTSsedmakVFDabjlhIQIr1StZaWB3AG1S1HNeo
89gce4N0CgcgyDDFsDsCGe437FGUnKt5mDrcSIF4woijFtMv3mNbWqRuOTI3b2BJ
zFbSDf2HKCUv4j6A+97qAp/fIUlQhBPaTgd/svyP7h/eFMof1fR+/+7zxrRnIToC
GHBnFtwbMbKr8CtGJjT4Dq41VRVGEAgsIAQgwpSECoi959B+T4Gb904V+w0MDA+Y
/UfsMH66OvyH13U2FmXU2B95C47gsPGFP3x8wBYXA2oFzSfGV57hLh8p6zvM32mp
vJrD1JmfGGxbvgesNY+5MdQQvQm8Ce3ebZO+MPixZDmdOlPHtODgLuCJOpwqbDYb
i3MLy0M21ugNtpSQjGgo+CMF7tT7EONGB4fOnUQ/SHpGiEWQk859hAsG8hG1WflS
v5SHJN2q4mSTTR+gf4H+ZzOE6oOtSYcUkUx+bBN1LGxwY/mP6OQcAaQ4+4cNgmqV
ktKvtaibhtUUiqYxSk7EUkBPwhkh3HUNxHEgkJGpYg3CBxBgbcIZtygwH9IQT6bu
f2qNp4uK22aMWeR/tacdNhjpeDY5/e79+MeBik6qcTbpbbb3ZP2OLFRwUnOT0SeW
6TNHV4Ore2yzVrMWu2o5J3sGdBJ2Ah7JCcQ3GA7/wcy5MMWSLm6L3uFw8PnSruLb
vR6SLoRAojRfvZIlDsOBZbists17CnvSO4hovud3H0YyqW28ls6SJ7TE6FLzea69
7bJ3Mx2Ld5GRt2ENqZkhEKwuJq4kBeWYeSGRRbVmpKAlBCYMhyeZbR2c4xgIiCjU
6M3t4m4cqthpV9jrJ261xk0lOCsMiux28I9HDOePFmvUnXVV7h3RGTjDc9zvOyfN
w1XecpMke6xLH7bh55BjKWMOWMiUBC+2+cfLZUbC84wpfn++JvDUpkazWQhiWjBT
zMYQVOIf2g4mkBfp/l/H+txeH1YyOj3Zze5nv3XWvbJPuHi9nMfSyN22wcz5STJE
6isn7mSMJrl6vn3ah7hXbt8+e/so8j/82c1myuTpJzHkqQyVum9jgxSpV+u4sKT6
ZNoo+Xa73A4VZHAoYpeAbec84s8jU31WxR+16D6zYWn8J9ZmLr5QdW83mF4E3TCi
g/nGwdAPFCor+bu38onbHThOmtbtLY1aTXVJHajDXqo6n3Z7KbFU2TwcmbInBKiR
9XtjnVajBX9DtfJpDMfyPJp7mimonWAWrBvQ8InHacYuY8odZ4iw50Pi5DFfImyc
h/Mh3Fd9WZbiKqeHG4w8bPKEhIr7iAdcdqS8YRUIjiFBChDTTmdAoi/VbUDg0GjB
DZSfACFFY6sY4KlN8WrWnVqVpTYYqo9Sth7oJPJD4tv8t/K5u7rtlcyG0qfc1Gnn
kk/nrap2rwcmxJo/KaznZlxzfe8STH2Adtvdz8bFyCjGiWgdxIFubDZHqL5jlWdm
vA5JLnGGlJMwkauHVmhrihv7OxzoFjIp4dDzym1ZbCQuikkPT6jYcRETi2Xjhll0
rLVocFlZjJySNSeZ3oaI3+TkToLjBhxLDwAPtq4EB1jgctKpU7y1LYCJCKUo2SpU
hieMEDvq9qxxNlRwPYPDpFRXdtVRWMbnhNceUhuuyyYrLaSRipCqkqoqEXHYpzHq
4uianhwB7/c4NzFyyxVVSyR4SO76k26nJM9szimlNKZNRA0+DT0yi09AWCXokiLu
K7JdA3BA1kLwzK7DyFBawdDlL1KGKcypCKSIsGIiRiwGyYkeYQ5lTEDtRMrAuRS0
5wuA0DaxYEmBcLfgmTxnUay/p71bHsUmTy8nCV0LI+VplFwcodoGcOhQOmoyBhqG
4J5jKlEnA5U94wyAuI2M/MWS+KcFweQ0D3eWpgTWRd6eWzGlIXQ4bTmZzENjNghw
JKM5DyRMKbO1A1LZgcgZDl1U08h7Yi9C0Napl5cFDezkJw5eNBrSjNAzA57q3Jon
dSYpyb5O1s005aME2SkMkqGrJCgUS4GQwikhDJDbzODoevQivKI1TSkkYJZMw2pQ
xBRiEGTuzK95iQU5tzl25S0WjEYhyMxK/e5rFTBGnYu1iy1abBptHSFOEq8Ix6cH
l7xAV2FBJ4FSdwU0k2EhHeI4HcXZi5RwdghhxyKHSIwCyFEFYEXtBgOHbEvDPTgk
TwkkhLjNJkR9ggQsS0xTttD3E82lzLghgwxRJ4IYwsQK/XIyGmYW1Dq1nFpBA0IB
s5BrTq0opCQgQS9EkBcDoQfAw4qNKUuzoTmfSYSxCz7bB6rI0qZXJ+j6v0ODdV+3
FaSbN3psGm5TiA6BtOYSwH9adJ5bDpIGvIdWaBup3kkgglL2ue13em8ILsmXyIfA
qpOcapWvlvo9R2TDoPQT6xoLNMOYifFU9UpyWGz4I9+vjEPb0l9UtRbognCfUkjv
EQ7Vw61Rtxuf2B8N/I7hGUXs50dyqzw3LIK8LqE1EOGTjObr5nb1/Qs4/dibF6Sd
40xhohxcQhMZtuUEMLsBMDZnzF9UNOK4pPBqSXDm2NkyTj04IxjMRVVVUlU2VTcW
ScOAPsTu8cSNr54TM2Ne22RbIILhrwB7CVm1NZY1hx6ekXExFrQE5EFlYmrTZjWY
AoGu5qgovW5KaU5wMG5ZwkRo+h+QcMcTmbxO3Az4EFqJZhKRcK1GhMKmxqcRrZXM
F6OT10M2wjUwcTkaTFhZGkEiEcci5ZzNh8y9y8lmIFkNucKKuJqdjS25kIonYILR
tJkWDUopFsoHdZGmHCosiUEQZprpLqltpa5XpFYSpjLHp0ohwbDodN7PmpmcJ1Kk
MFPReMjlJtiVqSkg6ve+QVrvqiTcXYk0D6m8TFDzNO8jvDGyYQmWvUHrHAqi8jiQ
zCwQdDIIwZs2l7NC8ulNIGQ3YF42ES28lJxKWN6wgQi6x3WG0PeaHmqWktkcX6uE
xDROvQY9nxnI3Rs75H8KTDkzFRjRqkZYjGtsqsWOQiaTUcxp5mToZHLqMx6jGEkZ
BjIESUcys8H1GQOamw448NmXdx5Io8S0GxYuE23S2vvsFCEAgLDEMZMY7hhEm/6W
0oHJMQJ0y0OPZtUMBIqFh0W2qFnUZhiOLdDq5vCack7T1flVXVkpLThJt4DiFKhY
nvHi71WTfv0xXnmSbRSuWViYc+ZyTUp+9+ndNSV2k3NPaMk/Ww3P8J6ug+MrxiuZ
wo+mJryvtnI9YGIGA7zfs/L1Cx3o9YF28ym6c3WE5mPA4s5zbO2x4DlSIEJnLxHg
ry1GCRvLZtAaqatLGI3ew+HA2h2j0ZO/1Ocs9WbLFsjsgJckmTR1NuY5RMJHpYiR
cIcZxGnrvi4siuBHf7Rw2c6cuHNj5WSaUehtEk5ehsc3m2iKHbT0oxxNmVTUeyss
53AtFlAlxFpaCfB0dxqLy8g+DBE1kWqTnER2IRvO2CJh65AfrUUoTekdwlPBLZFo
ttkj28KVt+Dp8AdMSYUoDUVxpKY9bUgxOr8pZRCi3UtywlKIjkycAh0hZCWTxSaE
SJEjJMY0BNgmY6gDJPMWXWrBDFuVE4yHJkPxbOpOUO9X3yn9dhkk0NAYLu301BQQ
xwHvlc+4RZAhFF2ZMzdEQ0dJ4tTslHJyew4xtJ/Zpie15/LClno1h+KxkO319X2N
3Sec8JNIrxqtZSonYwrCOBR0MSwnk0WSZq20MBDryk6G8bDSdz7jTfdkSTs3W8KV
v1OcmDmhxNJG89CTmn0d/Rxc704aLqIx3TxOXtlxdXU0jSJTw5vv7TYSzgPsyJ4d
Tya3gfjslW1LYWllE5n8TmdZUnk4uDrO7DSx8EytmcGVNnSqWSmTaUC8yaE99gNh
eZOPk9ZR9AzHBN0ZwU3ge47g8JfQSKh4DzMA6WiWkWjJRJ56kFSD4QBfwEA2HZcY
bXygwgkIXjLOb7TUV5RVV++1E/f8hs/E/EPKHwSHIYQ9gypAESRiIIZPtSYjIwqy
8HcHFB5ATc6keRuL1M4SqQLWL18alNHYyOc5tSR/DToo5OhDR8nHtI3njD1UYiQL
woEM7HyaGhQ6980Jtabh3ZVeDlbyaZq5Gk5FZjczjUjoHUa814moSmjWBr6u68Do
HALFsNAGWExbqOqIUWFERioQXGLSWQbGCcVKpjt6iPjJHMpP21HkqEaWWWWVKipA
1UJ3hiFqsDFBThFuBtt7DgZLVn0noN4e2WqWWW1UsUlL5zemT5yDRzhEAN6gcXjE
Nx78sIlVV4bGrJTxmjehdFdzArNDKngHSQkMQoCTCzlQvljILIfuaBxsI6RCekgP
TwMlHMN32gY4nZ6HK1SUKVCRNCE8QZlMzvJKQmhAmTGTEPPu7VYRQiwF5iGDrUAz
EQkvajGMRTuDsVO9vJzYmIpDLMJ3YHp9/ORNw26zBPZPHcChe9YbjdebB+AV4z09
zVVKCDj4rTE1xlDF4+PFVbpxkTFVbjjAVXZbVzluDXA2TO/bziCrjF23ZnAwOcyN
XJz8g7KaM1TQ6plQ0DAswBmow9u2uCpkM3rW0U4BKmitmInc1wcB8pNmpTn6vMx4
rPzWHadrq+Y6KyfDSqg4FbKqFRQoVIUoekwPeyCYdxvFMk1YPNTguVFFFBRlck56
OcyYYGfAMrjIOMs4HJzFinRD1K0EW9vLQg+A5goXaBntVWbpITeRaDQghsPgf5Eh
LzsXZx8qOpGKL2lkssqyqpVW2LVovhYhEYsVEEMCAxBBIbGD875g0eKkYbse6Wzn
Kd708rt5MZpukmOL93gjTxTqDoxPhNbJp4urTGcJ2OssttlUuHzuf0SJfR4OMN+J
4Uup3FTfoNw8PRW3FkkyyrI6P4FfAjbY/pzwsCk90Cz4vxeY8VwhoBraCMXj4k+b
iOgEeY5U86tyVBixyfS9jyJ8GwqXrGjjxJWEIaGgRsWlZH/HDXEXEDcEQCDN2iHd
3Mjt057nuU1HcsOV1fznTJ4L3YmUnSR1TInao73FHA+d9jI6xHYpvDco4vL9PVnX
LZPvpwdiG1STi5V1Yw3cJcSzYcFCnOczMDDezDehN5LQKCDD5+KcMDSUUWGBlJRS
n6ISKSE4C8maNiVDmliMRE8lXgyiqQdorOrOGtNWs5DGWbyTBHJ4tRGk2PqP3Gd+
jykJ7x5RqA2QZ47Xh0Gwc3aVqLIUDEsx3TZMljTMRbGzbCaa/DpuNBssWe6tDSJt
JZwkmpEqpVoY/KkaaaUnnJ4D2Rvu7zx4H4bPobJgvWOhOQVLCoqSqosiUwWxFaBc
Q1UgPGM2ZxVvCGR9V1QDUHEuJp7skbK202aEsOpXsHxw5ydNywrhNEaYMam53Nok
1KhKqTSjZqMmG+o1IjLJMVkyJntcU4tCG7I+BifNGFIPxURIIlk+L9ilQ+DR9+Gr
tHGkQ3yL9ZTjM16pEfE44XMnEggTZZbG0j3b9FakjrVpbETKcpW1STRZEqrt09fZ
EWxIeKlWORulkKsiqiwkjjIn648Z+DmtJ+ozFPdTBbaFizEZEfmHd2Ie7upKmKkt
OH7/AhKQ+IBvyc44diCEkAHiegt+NUJhIDJU2HtjuTaI/RY7fWzsyZSzJjm1mqGU
8VgUkkhxlKUW0ql75/yK9BcY0WDTbDSTclO5SMLYknA4owfr+yb+Pf6LYtRK5+Lp
2nlx3cJ9h+BxPGFpUVO5w+09NmRZVFWtzc9iextC9Ez9mqYUw4BCWl+90Os0ahy4
pDGaMDQmy1vGlTJFirLLcZW5kj6GML8D54btDsTdHpI8abHJs9yTr6zjY7XJ0T8K
8GjnBepP33BzjqNoQ2m4eBuh0m6y/EnuvYk/GlkZYW2pzkObOTycnZmX+VmNMGbt
2PjpvMpXxj69+PEz7Fr1fb6vF6NN+/DKTzUlEA3qY16TELjIthCwJ1SjNKRyvDiE
LyEIfd5Uoge+vZ77nytr+D00DkQhbSQB7PV7pn2SHKe0HanAygxVET7opwm1ULEY
wxjBhdaMkOzRQTVKxmEhT+Y0UNaEQzGwDJ3phosUQG8ZDBBNlCkRBNUUYiimSNEa
NusaasY4uWRhVufUH4w+ofMJjN3c75uanxYTHGf3Zh0K2fBzIdDbuiu2Jjuqfczx
adDvjT0Ru5KVyVI8Vs4cbMnN1hm7NDhTjLwmTy0DlHjdWJk2YbGbYYe2M1qc3cNA
mxKM0gjCiHQtFnMTRhQTQUqEUUlLzlDIDBk+4x92yHOE1JWITIBiQoJvAhrSo2JF
t40mcenQ15G8xy28TxG25Gkd4v0WnUKeBWUZ3VyTF8uoKUbxbaOOSQ9NtbdrJo8p
vpuU4KZI26dzqknE5uauLFL46aVt8xwOI6Ry+RsjhxkptyMcpIMcab2Mk/I7bbDG
jWtafRhVIybReB415WdSlFj7W0mjis2RmZYFGqCRJkKUtAS79F06sp5gZSIwGbbR
gViKaidQeaAmiFie+g9xYY4jbsSFSiAyFAqCEpSVhua0uMTUlP8VNn2TkfjVq21H
d3DgzQ5sYZizNmChDlO4QIi4p8ywXPgIhe2FgZFvceZDmUwTeO9zooJ7dBzY6xo4
vsp2+y9LjVWrjvTMh8Hq097FZJ8X2fXry9xkuBmHO8EN2zIcEJDDYEKs9UXZszLj
G7HFqMCIUFC0qXxSQUoiDbmDe5o9+jCXbyGx9iY2Pn3kJr9z5RFsSSEVLBO1RxHI
YRJG8EcXUWiUHaKJBLthSYopg9JkQCLANRfqL+ROsyserodkbHalmQsaUrTEUq2W
orGPiNO5U1izGJd8ZabyJD4N+97G3cBkWB5VghK5MARAngn8ultNuX7anKPXgz9G
fmcyTNyPwYfpBVotFMauWGgDINwNlQnZ32yJZ0WVU7SK18T8muLsqUGjBY4WG0N+
EUK7I4bu3bvw+BzauEuNqaHQWFYsNZs7EwGgoJLEcTF55lja+trUtSDLpwtghMOt
CyqhxvEUmUjnYglzctES5uuimYmzmrqeL3jdWHcM6tKzzZs7lpk0YBMw5mCQJhof
04Wt1S4F8yTTQ31WrungG/KhxxxAIfJjYQjWTYcLE2JI6EeY2wOJA6CxKbtU6by0
t9TDRU9HsrustzA50ZO/Ng0qZNrLV9y7BLPIprDMdp4KGQLCHasExDQ+FN2YQaCz
MM44SMat8uCMam9zsY8EGkjTK03ZgT57Z542h7UO19Ae03T0fycYfMnF6EcDzeeH
z64xzliqbVKlnhWrLZpSuRXtsdbGdkB48Hs9vD9tiee5h2+ofVZbItt0bFPbPetX
IrFVh0acZPRhlLrJXbMSksUjzZJUukck4cXuayqO34cO7RfhW2Ts8hMMTmYYH6xo
/OwnkB8H1qgrhAHIKYgBGLiTKUAMossqiVgtWxTlAEOQPjDwk7CB/ZE1tEk+/2DT
jPgr3yOGztYUyTTDFWJZi0Yy5JTIqmCu3t2bG0oxkkyFkyMsyY20bl4QsfBYP4j1
5HLsYgAQUMOp0HHlsiDLuPafYQuFtvFvxeR0q9Nn9A1Y0AnQBMWb15ZkjgyQCG+8
fYjIyzmCGbN2ixIHpo4YEEuWEEyYKwFDlhRB9Grj3ZhzUexccZSAtCqPg7WAg/mN
dAkSlnOePHn244uBpWOGEstlDiY2tshopKeNkRlOyVhXcxGO/Tsds6WLNBA5lhBU
mkNSseK3zMGWTiTNTGkbMZuGp/BCBeyYI85S96mGCaO4ujezCbpkwVYU65VtEOhs
PX9kNA8ZyC92pJOcKjYai7O0cw37HaRNlFITA2GAlozMlMMU5uaI0HFednJwDJ1K
SYWJHKdjdqTeowqRviTETcWZZMilWgdY7gwm7KOpKTqMhrZomQMQiSympZSmF4N5
vwVHVJH4pGJ3ueEIsfxskTuTqkE5HJJqaDpqpUW7VYqkWl7KjEkWFh8Pma8e553N
NYQokexsXRyDe81qlhF3iR1hwsvC42x8r2ImOP9h4wTkDzcU3kQ+VQ8ObKWPtqbv
kx68nBEjwmx117tPDq6TzsMySO7j7PVjLWdZNWWlaVyWNSSK2ozZDeSWInY7Zhpd
hs6zspbB5pZ7VYkWScVTaUs35pp+f2uc6Ap8ysJ38gb2kQ4Fylo5eIouW18eIg0b
WBaMUkMiccenozLjFO/OzWoOWeZ1NpG82E/DqQbLE1BHOwmQ31tJ3R7ByeabhCiu
Q9vKMOwvBpaG39BvV3qKFoAY+LUUaK2wF4RUK/Uon/5FANgc4A7glifKaBgNw+9Q
8AcwmY/ih0pwNOBMjcZGtsH7G5LkX+VU9iUMgesC8Dk7bW8qoRklLZQSKbTYL4cF
ptFE6E0X8hpaF5E4Zk5Fk7C0p46/afkLDke+X6YqJbIdLFuQHHQBOfiQEdhj+EL0
O4S8UBvuHCSq2ZhhilksFd7om82jZTjYEysq2i2uiCq4wS55TmKVosUwNUIVUt4s
jJRtNTIsJ9bGNgxwnBw7WctmKn8OpbN9citNMbm2EcXJhPMo1IHkpDj7aigyzH1H
OgfGmg3Tq8vZ7MwfZKml+67DCr0mDThMMLrEqL6CxXtTbmWG43UcfOeZQv3fF/Ob
xu3lq1J+NkYY4SMUkppbLTglGRH8hwM+dU7Is+G3X49o4N76pquSl6lKcTVcLweg
LO8QTColstJDFTLydeszwuTJQxG8Qc31G0RC86wRFPPVkqpISopDwYgpFIJArJ7i
gKw/CEU9qkmgQ3Syp4YQmHCaZJmMNMCsiGmWSNNVgsEv/4u5IpwoSGbkLraA
------------0eH4UwucgQn9AZZoRrhJ2R
Content-Disposition: attachment; filename=pktcdvd.bz2
Content-Type: application/bzip2; name=pktcdvd.bz2
Content-Transfer-Encoding: Base64

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

------------0eH4UwucgQn9AZZoRrhJ2R--


-- 
VGER BF report: U 0.533427
