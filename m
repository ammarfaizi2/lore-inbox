Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317016AbSFFRCd>; Thu, 6 Jun 2002 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSFFRCc>; Thu, 6 Jun 2002 13:02:32 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:14012
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S317016AbSFFRCa>; Thu, 6 Jun 2002 13:02:30 -0400
Message-ID: <3CFF9590.5030504@st-peter.stw.uni-erlangen.de>
Date: Thu, 06 Jun 2002 19:02:08 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5.20]newbee call for help getting lvm working 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *17G0eL-0003IU-00*i/Tb9kU/LNA* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
i was trying to get the patch from Anders Gustafsson working in 2.5.20,
but i'm getting  by compilation:
....
lvm.c: In function `__update_hardsectsize':
lvm.c:2021: warning: implicit declaration of function `get_hardsect_size'
...
and by make modules_install:
...........
depmod: *** Unresolved symbols in 
/lib/modules/2.5.20-dj3-lvm-xfs2/kernel/drivers/md/lvm-mod.o
depmod:         get_hardsect_size
make: *** [_modinst_post] Error 1
............

it seems that this function is disapeared between 2.5.18 and 2.5.20
(the patch from Anders Gustafsson is against 2.5.18)

can smbd please help me to solve this issue

regards

svetljo

the patch : 
http://www.linuxhq.com/kernel/v2.5/unofficial/v2.5.18/patches/lvm-cleanups-2.5.18.patch

and the correspondig text from drivers/md/lvm.c :
..............
static void __update_hardsectsize(kern_lv_t *lv) {
    int le, e;
    int max_hardsectsize = 0, hardsectsize;

    for (le = 0; le < lv->lv_allocated_le; le++) {
        hardsectsize = bdev_hardsect_size(lv->lv_current_pe[le].bdev);
        if (hardsectsize == 0)
            hardsectsize = 512;
        if (hardsectsize > max_hardsectsize)
            max_hardsectsize = hardsectsize;
    }

    /* only perform this operation on active snapshots */
    if ((lv->lv_access & LV_SNAPSHOT) &&
        (lv->lv_status & LV_ACTIVE)) {
        for (e = 0; e < lv->lv_remap_end; e++) {
            hardsectsize =  get_hardsect_size( 
lv->lv_block_exception[e].rdev_new);
            if (hardsectsize == 0)
                hardsectsize = 512;
            if (hardsectsize > max_hardsectsize)
                max_hardsectsize = hardsectsize;
        }
    }
}
............................

