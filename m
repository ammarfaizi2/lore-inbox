Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273940AbRIRVaB>; Tue, 18 Sep 2001 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273942AbRIRV3w>; Tue, 18 Sep 2001 17:29:52 -0400
Received: from saga18.Stanford.EDU ([171.64.15.148]:13484 "EHLO
	saga18.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S273940AbRIRV3n>; Tue, 18 Sep 2001 17:29:43 -0400
Date: Tue, 18 Sep 2001 14:29:57 -0700 (PDT)
From: Ken Ashcraft <kash@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.Stanford.EDU>
Subject: [CHECKER] two probable security holes
Message-ID: <Pine.GSO.4.31.0109181355560.15933-100000@saga18.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm starting work on a new checker that looks at user pointers and makes
sure that they're treated safely.  It should catch things such as format
string holes, derefrencing a user pointer, and passing a user pointer to a
trusting function (i.e. the destination of copy_from_user).  Here are a
couple of the reports so far.  I just want to verify that these are holes
and that I'm on the right track.  Also, if you have any ideas please send
them my way.

Thanks,
Ken Ashcraft

Watch ifr.ifr_name.

2.4.9-ac10/drivers/net/tun.c:
static int tun_chr_ioctl(struct inode *inode, struct file *file,
                         unsigned int cmd, unsigned long arg)
{
        struct tun_struct *tun = (struct tun_struct *)file->private_data;

        if (cmd == TUNSETIFF && !tun) {
                struct ifreq ifr;
                int err;
Start--->
                if (copy_from_user(&ifr, (void *)arg, sizeof(ifr)))
                        return -EFAULT;
                ifr.ifr_name[IFNAMSIZ-1] = '\0';

                rtnl_lock();
                err = tun_set_iff(file, &ifr);
                rtnl_unlock();

        ...
}

static int tun_set_iff(struct file *file, struct ifreq *ifr)
{
        ...

                if (*ifr->ifr_name)
                        name = ifr->ifr_name;

                if ((err = dev_alloc_name(&tun->dev, name)) < 0)
                        goto failed;
        ...
}

2.4.9-ac10/net/core/dev.c:
int dev_alloc_name(struct net_device *dev, const char *name)
{
        int i;
        char buf[32];

        /*
         *      If you need over 100 please also fix the algorithm...
         */
        for (i = 0; i < 100; i++) {
Error--->
	       sprintf(buf,name,i);
                if (__dev_get_by_name(buf) == NULL) {
                        strcpy(dev->name, buf);
                        return i;
                }
        }
        return -ENFILE; /* Over 100 of the things .. bail out! */
}


and report #2:

/2.4.9-ac10/drivers/ieee1394/video1394.c:
static int video1394_ioctl(struct inode *inode, struct file *file,
			   unsigned int cmd, unsigned long arg)
{
	...
	case VIDEO1394_TALK_QUEUE_BUFFER:
	{
		struct video1394_wait v;
		struct video1394_queue_variable qv;
		struct dma_iso_ctx *d;
		int i;

		...
		if (d->flags & VIDEO1394_VARIABLE_PACKET_SIZE) {
Start--->
			if (copy_from_user(&qv, (void *)arg, sizeof(qv)))
				return -EFAULT;
		...
		if (d->flags & VIDEO1394_VARIABLE_PACKET_SIZE) {
			initialize_dma_it_prg_var_packet_queue(
				d, v.buffer, qv.packet_sizes,
				ohci);
		}
	...
}

static void initialize_dma_it_prg_var_packet_queue(
	struct dma_iso_ctx *d, int n, unsigned int * packet_sizes,
	struct ti_ohci *ohci)
{
	struct it_dma_prg *it_prg = d->it_prg[n];
	int i;

	d->last_used_cmd[n] = d->nb_cmd - 1;

	for (i = 0; i < d->nb_cmd; i++) {
		unsigned int size;
Error--->
		if (packet_sizes[i] > d->packet_size) {
			size = d->packet_size;
		} else {
			size = packet_sizes[i];
		}
	...
}



