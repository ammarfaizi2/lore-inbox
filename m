Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTFOVKz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 17:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTFOVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 17:10:55 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34003 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262872AbTFOVKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 17:10:52 -0400
Date: Sun, 15 Jun 2003 23:24:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: top stack users for 2.5.71
Message-ID: <20030615212443.GA1181@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

44 functions for 2.5.67.
45 functions for 2.5.68
41 functions for 2.5.69
36 functions for 2.5.70
32 functions for 2.5.71

Five less, one more.  The newcomer this time is in
drivers/usb/storage/isd200.c:
0xc0b9c9a0 isd200_action:                                sub    $0x444,%esp

This is curious, since no obvious change causing this is in the 2.5.71
patch.

The two big consumers on the stack are these two, that use a little
over 256k and a little over 512k respectively.
        struct scsi_cmnd srb;
        struct scsi_device srb_dev;

This one really puzzles me, as those two variables were already present
in 2.5.67.  A closer look reveals that the function isn't exactly new,
just oszillating around the 1k limit.

2.5.63:
0xc08c0be3 <isd200_action+3/1ac>:                        sub	$0x16c,%esp
2.5.64 - 2.5.67: <1k
2.5.68:
0xc0b73c60 isd200_action:                                sub	$0x424,%esp
2.5.69:
0xc0b4bea0 isd200_action:                                sub	$0x414,%esp
2.5.70: <1k
2.5.71:
0xc0b9c9a0 isd200_action:                                sub    $0x444,%esp

Quite an interesting behaviour that I don't fully understand yet.


P 0xc022f0d6 presto_get_fileid:                            sub    $0x119c,%esp
P 0xc022d896 presto_copy_kml_tail:                         sub    $0x1028,%esp
0xc0929258 ide_unregister:                               sub    $0x96c,%esp
0xc0e7f4d3 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc0876936 w9966_v4l_read:                               sub    $0x828,%esp
0xc0e0fb0b snd_cmipci_ac3_copy:                          sub    $0x7c0,%esp
0xc0e1012b snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02df9b6 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
0xc0223996 presto_ioctl:                                 sub    $0x508,%esp
0xc0e797a8 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0ea1526 snd_trident_mixer:                            sub    $0x4c0,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc093fff1 ide_config:                                   sub    $0x4a8,%esp
0xc05e404c parport_config:                               sub    $0x490,%esp
0xc0c5ba23 ixj_config:                                   sub    $0x484,%esp
0xc1085e3e gss_pipe_downcall:                            sub    $0x44c,%esp
0xc0b9c9a0 isd200_action:                                sub    $0x444,%esp
0xc03bc848 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc04637c3 befs_error:                                   sub    $0x418,%esp
0xc0463833 befs_warning:                                 sub    $0x418,%esp
0xc04638a3 befs_debug:                                   sub    $0x418,%esp
0xc07d27c6 wv_hw_reset:                                  sub    $0x418,%esp
0xc16c9365 root_nfs_name:                                sub    $0x414,%esp
0xc0c7f2d2 bt3c_config:                                  sub    $0x410,%esp
0xc0c833e2 btuart_config:                                sub    $0x410,%esp
0xc0c7d89f dtl1_config:                                  sub    $0x408,%esp
0xc0c816b6 bluecard_config:                              sub    $0x408,%esp


Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
