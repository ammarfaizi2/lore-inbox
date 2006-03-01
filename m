Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWCAWYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWCAWYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWCAWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:24:12 -0500
Received: from duempel.org ([81.209.165.42]:64190 "HELO duempel.org")
	by vger.kernel.org with SMTP id S1751323AbWCAWYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:24:11 -0500
Date: Wed, 1 Mar 2006 23:23:05 +0100
From: Max Kellermann <max@duempel.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc[1-5]: soft lockups on Athlon64 X2
Message-ID: <20060301222305.GA12138@roonstrasse.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060227122705.GA27141@roonstrasse.net> <20060228221948.3d76f80b.akpm@osdl.org> <20060301100744.GA1041@roonstrasse.net> <20060301022235.51f47b42.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20060301022235.51f47b42.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2006/03/01 11:22, Andrew Morton <akpm@osdl.org> wrote:
> I guess it'd be useful to see where all that time is spent, if you have
> time.   Enable CONFIG_PROFILING, boot with `profile=1', do:
> 
> readprofile -r
> mount ...
> readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40

Here it is.  As an explanation of the profile's scope, I have also
sent the shell script which reproduces the problem on my machine.

The script however is not 100% reliable; sometimes, the lockup just
won't occur.  Sounds like a timing problem to me.

btw. my other partitions are also reiserfs (but not encrypted).

Max


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=profile

     0 *unknown*
ffffffff81030f20 do_syslog                                     1   0.0009
ffffffff81041cc0 __queue_work                                  1   0.0078
ffffffff81054540 find_get_page                                 1   0.0104
ffffffff81062db0 __handle_mm_fault                             1   0.0004
ffffffff8107a450 __getblk                                      1   0.0017
ffffffff811fce50 xor_128                                       1   0.0312
ffffffff811fd140 cbc_process_decrypt                           1   0.0035
ffffffff8122ec60 strncpy_from_user                             1   0.0125
ffffffff812dc9b0 scsi_dispatch_cmd                             1   0.0014
ffffffff8101c120 do_gettimeoffset_pm                           2   0.0417
ffffffff8101eee1 enc128                                        2   0.0010
ffffffff810910b0 get_filesystem_list                           2   0.0139
ffffffff8122e990 memset                                        3   0.0156
ffffffff8105c4b0 __pagevec_lru_add_active                     12   0.0500
ffffffff8105c790 __pagevec_release                           108   1.6875
ffffffff8105c2c0 pagevec_lookup                              112   2.3333
ffffffff8105c6d0 lru_add_drain                               144   1.5000
ffffffff8105d100 invalidate_mapping_pages                    411   1.2844
ffffffff8105c2f0 release_pages                               551   1.2299
ffffffff810096e0 default_idle                               4194  37.4464
ffffffff810c9b50 reiserfs_dirty_inode                      23849 165.6181
ffffffff810545a0 find_get_pages                            24892 172.8611
0000000000000000 total                                     54291   0.0100

--1yeeQ81UyVL57Vl7
Content-Type: application/x-sh
Content-Disposition: attachment; filename="trigger_soft_lockup.sh"
Content-Transfer-Encoding: quoted-printable

# cleanup=0Aumount ~max/dl=0Aumount ~max=0Acryptsetup remove max_home=0Acry=
ptsetup remove data=0Aset -e=0A# mount first partition; this runs OK=0Acryp=
tsetup --cipher=3Daes create max_home /dev/sda9=0Amount -t reiserfs /dev/ma=
pper/max_home ~max=0A# mount second partition=0Areadprofile -r=0Acryptsetup=
 --cipher=3Daes create data /dev/sda10=0A# the lockup occurs in this mount =
(not always)=0Amount /dev/mapper/data ~max/dl -t xfs=0Areadprofile -n -v -m=
 /boot/System.map-2.6.16-rc5-woodpecker-test |sort -n -k 3 |tail -40 |tee p=
rofile=0A
--1yeeQ81UyVL57Vl7--
