Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbTCUGWw>; Fri, 21 Mar 2003 01:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263282AbTCUGWw>; Fri, 21 Mar 2003 01:22:52 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:5591 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263283AbTCUGWu>; Fri, 21 Mar 2003 01:22:50 -0500
Date: Thu, 20 Mar 2003 22:33:45 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: [CHECKER] potential dereference of user pointer errors
In-Reply-To: <200303041112.h24BCRW22235@csl.stanford.edu>
Message-ID: <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are the the Stanford Checker team that constantly send error reports to
the linux kernel mailing list. Enclosed are 10 dereference of user pointer
warnings catched by our checker. We started by marking the second
parameter of copy_from_user (to, from, len), the first parameter of
copy_to_user (to, from, len), and all parameters of the sys_* functions as
tainted, then propogated the tainted annotations along call chains. If two
functions get assigned to the same structure field, we propogate the
tainted annotations between them, too. An example of such propogation is
the warning about drivers/media/video/cpia.c::cpia_write_proc and
drivers/media/usb/media/vicam.c. The error message uses "thru
struct_name:field_name" to represent such propogations.

We are not sure if these warnings are real bugs or false positives, so any
confirmation or clarification will be greatly appreciated.

Question: can the write function to /proc file system takes tainted
inputs? Originally we think so but we've found some number of write_proc
functions in different driver modules that dereference the inputs
directly, so it is likey that we are missing something.

If any of the error message is not clear, please email me.

Thanks.

[BUG] not sure. the dereference occurs at a tainted place. call
copy_from_user (, data, ), then copy_from_user (, *data, )

/home/junfeng/linux-2.5.63/sound/core/seq/instr/ainstr_iw.c:92:snd_seq_iwffff_copy_env_from_stream:
ERROR:TAINTED deferencing "data" tainted by [dist=0][copy_from_user:parm1]

[BUG] cmd is tainted. then they do copy_to_user (cmd->resbuf, ...) resbuf
is declared as a pointer, not an array, so cmd->resbuf can point to
anywhere.

/home/junfeng/linux-2.5.63/drivers/message/i2o/i2o_config.c:440:ioctl_parms:
ERROR:TAINTED deferencing "cmd" tainted by [dist=0][(null)]

[BUG] cosa_getidstr calls copy_to_user on arg, which implies arg is
tainted.

/home/junfeng/linux-2.5.63/drivers/net/wan/cosa.c:1109:cosa_readmem:
ERROR:TAINTED deferencing "d" tainted by [dist=2][called by
cosa_ioctl_common:parm3 calling cosa_getidstr:parm1 calling
copy_to_user:parm0]

[MINOR] in debug data

/home/junfeng/linux-2.5.63/drivers/usb/serial/kobil_sct.c:429:kobil_write:
ERROR:TAINTED deferencing "buf" tainted by [dist=0][copy_from_user:parm1]

[UNKNOWN] sys_quotaoctl is a real system call. The entry point is at
entry.S. But this file is under subdir fs. So there must be something we
are missing

/home/junfeng/linux-2.5.63/fs/block_dev.c:817:lookup_bdev: ERROR:TAINTED
deferencing "path" tainted by [dist=1][called by
/home/junfeng/linux-2.5.63/fs/quota.c:sys_quotactl:parm1]

[UNKNOWN] the warning itself is not a bug. cpia.c::cpia_write_proc calls
copy_from_user, which implies it can take tainted inputs.
vicam_write_proc_gain and cpia_write_proc are both assigned to
proc_dir_entry.write_proc. So either cpia_write_proc doesn't need to do
copy_from_user, or vicam_write_proc misses the copy_from_user
Should I assume that write to /proc file system takes tainted inputs or
not? or it depends?

/home/junfeng/linux-2.5.63/lib/vsprintf.c:64:simple_strtol: ERROR:TAINTED
deferencing "cp" tainted by [dist=3][ calling simple_strtoul  called by
/home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:vicam_write_proc_gain:parm1
thru proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc:parm1
copy_from_user:parm1]

similar things

/home/junfeng/linux-2.5.63/drivers/isdn/hardware/eicon/divasproc.c:info_write
thru proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc

[BUG] the write function can take a tainted pointer as input. in the same
sub direction, scanner.c::write_scanner does copy_from_user (should fix
the function pointer propogation thing, try to get the 'nearest' one.)

/home/junfeng/linux-2.5.63/drivers/usb/image/mdc800.c:794:mdc800_device_write:
ERROR:TAINTED deferencing "buf" tainted by [dist=1][thru
file_operations:write
/home/junfeng/linux-2.5.63/sound/oss/es1370.c:es1370_write parm1  calling
copy_from_user:parm1]

[BUG] under the same subdir, sisfb_ioctl and matroxfb_dh_ioctl assigned to
the same struct field fb_ops::fb_ioctl. matroxfb_dh_ioctl does a
copy_to_user on the param @arg, which implies it is tainted. sisfb_ioctl
calls sis_malloc and sis_malloc then deref's arg. actually, sisfb_ioctl
assumes arg is untainited

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

[BUG] guswave_ioctl does a copy_to_user on the same case branch
SNDCTL_SYNTH_INFO
/home/junfeng/linux-2.5.63/sound/oss/awe_wave.c:2049:awe_ioctl:
ERROR:TAINTED passing "arg" into deref cal __constant_memcpy [dist=1][thru
synth_operations:ioctl
/home/junfeng/linux-2.5.63/sound/oss/gus_wave.c:guswave_ioctl:parm2
copy_to_user:parm0]

[BUG] maybe. snd_cmipci_ac3_copy does copy_from_user implies src is
tainted. The only suspicious point is that in snd_cmipci_ac3_copy the
tainted parm is called src, while in snd_ex1938_capture_copy it is called
dst.

/home/junfeng/linux-2.5.63/sound/pci/es1938.c:833:snd_es1938_capture_copy:
ERROR:TAINTED passing "dst" into deref cal __constant_memcpy [dist=1][thru
snd_pcm_ops_t:copy
/home/junfeng/linux-2.5.63/sound/pci/cmipci.c:snd_cmipci_ac3_copy:parm3
copy_from_user:parm1]


