Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSKUVsQ>; Thu, 21 Nov 2002 16:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSKUVsQ>; Thu, 21 Nov 2002 16:48:16 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:17936 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264903AbSKUVsE>; Thu, 21 Nov 2002 16:48:04 -0500
Message-ID: <20021121215458.8534.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: smatch-kbugs@lists.sf.net, kernel-janitor-discuss@lists.sf.net
Date: Thu, 21 Nov 2002 16:54:58 -0500
Subject: [LIST] large local declarations
X-Originating-Ip: 67.112.215.16
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a smatch script (smatch.sf.net) that finds the the size of local variables.  I created an allyesconfig with 2.5.48 and tested it.  These were the functions that declared local datas with size of 5 digits or more (in bits).  Some of them should probably be changed to declare a pointer then use kmalloc() and free().

if (foo) {
        int frob[HUGE_NUM];
        ...
} else {
        int bar[HUGE_NUM];
        ...
}
This would not count against you twice, since the script takes code paths into consideration.

The function with the largest variable is riocontrol().  It is used deliberately for some weird hardware.  According to the comment, "it's hardware like this that really gets on [the author's] tits."

regards,
dan carpenter

size     file lineno function
16768	 drivers/atm/iphase.c 2874 ia_ioctl
11104	 drivers/block/cpqarray.c 1090 ida_ioctl
21248	 drivers/cdrom/optcd.c 1623 cdromread
524736	 drivers/char/rio/rioctrl.c 1784 riocontrol
15968	 drivers/ide/ide.c 1893 ide_unregister
16448	 drivers/isdn/i4l/isdn_common.c 1271 isdn_statstr
12320	 drivers/media/video/meye.c 400 jpeg_quantisation_tables
16552	 drivers/media/video/w9966.c 911 w9966_v4l_read
16584	 drivers/message/i2o/i2o_proc.c 1094 i2o_proc_read_groups
16640	 drivers/message/i2o/i2o_proc.c 2295 i2o_proc_read_lan_mcast_addr
16640	 drivers/message/i2o/i2o_proc.c 2525 i2o_proc_read_lan_alt_addr
23072	 drivers/message/i2o/i2o_proc.c 889 i2o_proc_read_ddm_table
12224	 drivers/mtd/chips/amd_flash.c 751 amd_flash_probe
35744	 drivers/net/e100/e100_main.c 2812 e100_load_microcode
16496	 drivers/net/wireless/airo.c 5949 readrids
16640	 drivers/net/wireless/airo.c 6041 writerids
32896	 drivers/scsi/53c700.c 1752 NCR_700_proc_directory_info
11744	 drivers/scsi/aic7xxx_old.c 11156 aic7xxx_print_card
16824	 drivers/scsi/cpqfcTScontrol.c 1630 CpqTsProcessIMQEntry
16496	 drivers/scsi/cpqfcTScontrol.c 648 PeekIMQEntry
24800	 drivers/scsi/qlogicfc.c 937 isp2x00_make_portdb
25808	 drivers/usb/media/ibmcam.c 3480 ibmcam_model3_setup_after_video_if
16280	 drivers/usb/media/ibmcam.c 638 ibmcam_parse_lines
16160	 drivers/usb/media/ibmcam.c 945 ibmcam_model3_parse_lines
11104	 fs/cifs/smbdes.c 270 dohash
33056	 fs/intermezzo/journal.c 1281 presto_copy_kml_tail
33344	 fs/intermezzo/journal.c 1633 presto_get_fileid
16512	 fs/nfsd/nfsctl.c 214 write_export
16512	 fs/nfsd/nfsctl.c 224 write_unexport
10336	 fs/xfs/xfs_da_btree.c 599 xfs_da_node_rebalance
27104	 fs/xfs/xfs_dir_leaf.c 763 xfs_dir_leaf_to_node
12480	 fs/xfs/xfs_fsops.c 381 xfs_growfs_data_private
11552	 lib/inflate.c 488 huft_build
10560	 lib/inflate.c 906 inflate_dynamic
10336	 net/wanrouter/wanmain.c 776 device_new_if
11360	 sound/core/oss/pcm_oss.c 453 snd_pcm_oss_change_params
16864	 sound/pci/emu10k1/emufx.c 2283 snd_emu10k1_fx8010_ioctl


The script used to generate the data:
#!/usr/bin/perl -w

use smatch;
my $max = 0;

sub merge_rules($$){
    my $one = shift;
    my $two = shift;
    if (int($one) > int($two)){
	return $one;
    }else{
	return $two;
    }
}

while ($data = get_data()){

    if ($data =~ /func_impl/){
	$max = 0;
    }
    if ($data =~ /end_func/){
	print get_filename(), " ", get_lineno(), " ", get_cur_func(), " $max\n";
    }

    if ($data =~ /decl_size\(integer_cst\((\d+)\)\)/){
	set_state("total", get_state("total")+$1);
	if ($max < get_state("total")){
	    $max = get_state("total");
	}
    }
}


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

