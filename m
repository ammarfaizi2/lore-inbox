Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131173AbRANB0T>; Sat, 13 Jan 2001 20:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131124AbRANB0J>; Sat, 13 Jan 2001 20:26:09 -0500
Received: from linuxcare.com.au ([203.29.91.49]:29960 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129998AbRANBZx>; Sat, 13 Jan 2001 20:25:53 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sun, 14 Jan 2001 12:23:03 +1100
To: linux-lvm@sistina.com, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, lvm@sistina.com
Subject: Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 0.9.1 beta1 available at www.sistina.com
Message-ID: <20010114122303.E20398@linuxcare.com>
In-Reply-To: <20010113114507.D15915@linuxcare.com> <200101130143.f0D1hNF19829@webber.adilger.net> <20010113170616.B22699@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010113170616.B22699@caldera.de>; from hch@ns.caldera.de on Sat, Jan 13, 2001 at 05:06:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The longs are the biggest problem AFAICS.
> long is 64bit on sparc64 and 32bit on sparc32...

Embedding pointers in ioctls is much worse. When this happens we basically
end up duplicating the ioctl parsing code (this code courtesy of jakub's
sharp mind, but it would be nice not to require this :)

Anton

        case VG_CREATE:
                v = kmalloc(sizeof(vg_t), GFP_KERNEL);
                if (!v) return -ENOMEM;
                if (copy_from_user(v, (void *)arg, (long)&((vg32_t *)0)->proc) ||
                    __get_user(v->proc, &((vg32_t *)arg)->proc)) {
                        kfree(v);
                        return -EFAULT;
                }
                karg = v;
                memset(v->pv, 0, sizeof(v->pv) + sizeof(v->lv));
                if (v->pv_max > ABS_MAX_PV || v->lv_max > ABS_MAX_LV)
                        return -EPERM;
                for (i = 0; i < v->pv_max; i++) {
                        err = __get_user(ptr, &((vg32_t *)arg)->pv[i]);
                        if (err) break;
                        if (ptr) {
                                v->pv[i] = kmalloc(sizeof(pv_t), GFP_KERNEL);
                                if (!v->pv[i]) {
                                        err = -ENOMEM;
                                        break;
                                }
                                err = copy_from_user(v->pv[i], (void *)A(ptr), sizeof(pv32_t) - 8);
                                if (err) {
                                        err = -EFAULT;
                                        break;
                                }
                                v->pv[i]->pe = NULL; v->pv[i]->inode = NULL;
                        }
                }
                if (!err) {
                        for (i = 0; i < v->lv_max; i++) {
                                err = __get_user(ptr, &((vg32_t *)arg)->lv[i]);
                                if (err) break;
                                if (ptr) {
                                        v->lv[i] = get_lv_t(ptr, &err);
                                        if (err) break;
                                }
                        }
                }
                break;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
