Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbTCYMVc>; Tue, 25 Mar 2003 07:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbTCYMVc>; Tue, 25 Mar 2003 07:21:32 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51929 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262291AbTCYMVa>;
	Tue, 25 Mar 2003 07:21:30 -0500
Date: Tue, 25 Mar 2003 13:31:27 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66 new fbcon oops while loading X / possible gcc bug?
Message-ID: <20030325123126.GA10808@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While loading X, I get this oops. The weird thing is that I don't use
framebuffer. I compiled with gcc 3.2.2 but the code generated looks weird.
Virgin gcc 3.2.2 on a pentium III.

Oops, followed by my unskilled ruminations:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0275a13
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[fb_open+51/208]    Not tainted
EFLAGS: 00013282
EIP is at fb_open+0x33/0xd0
eax: 00000000   ebx: 000000e0   ecx: 00000001   edx: 00000001
esi: cbd436e0   edi: 00000000   ebp: 00000000   esp: c9589f24
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 497, threadinfo=c9588000 task=c96b27e0)
Stack: c9554720 cbfea4e0 00000000 c9554720 c89b0604 c0150bde c89b0604 c9554720 
       c9554720 c89b0604 cbfea4e0 c01481ca c89b0604 c9554720 00000002 bffffb78 
       cbfe2000 c9588000 c0148008 c937e940 cbfea4e0 00000002 c9589f80 c937e940 
Call Trace:
 [chrdev_open+94/112] chrdev_open+0x5e/0x70
 [dentry_open+442/480] dentry_open+0x1ba/0x1e0
 [filp_open+104/112] filp_open+0x68/0x70
 [sys_open+91/144] sys_open+0x5b/0x90
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 8b 00 85 c0 74 0b 83 38 02 74 6a ff 80 c0 00 00 00 85 d2 b8 

gdb traces fb_open+0x33 to:

(gdb)  l *(fb_open+0x33)
0xe23 is in fb_open (include/linux/module.h:286).
281	#define local_inc(x) atomic_inc(x)
282	#define local_dec(x) atomic_dec(x)
283	#endif
284	
285	static inline int try_module_get(struct module *module)
286	{
287		int ret = 1;
288	
289		if (module) {
290			unsigned int cpu = get_cpu();

>From the oops: Code: 8b 00 85 c0 74 0b 83 38 02 74 6a ff 80 c0 00 00 00 85
d2 b8

This output looks somewhat bogus to me as it appears to try to dereference
'module' before it has been tested for zero or not:

static inline int try_module_get(struct module *module)
{
c0275a08:	8b 86 94 01 00 00	mov	0x194(%esi),%eax
        int ret = 1;
c0275a0e:	ba 01 00 00 00		mov	$0x1,%edx
c0275a13:       8b 00			mov	(%eax),%eax

        if (module) {
c0275a15:	85 c0			test	%eax,%eax 
c0275a17:	74 0b			je	c0275a24 <fb_open+0x44>
c0275a19:	83 38 02		cmpl   $0x2,(%eax)
c0275a1c:	74 6a			je 	c0275a88 <fb_open+0xa8>

which is called from fb_open:

static int
fb_open(struct inode *inode, struct file *file)
{
 	int fbidx = minor(inode->i_rdev);
 	struct fb_info *info;
 	int res = 0;

#ifdef CONFIG_KMOD
        if (!(info = registered_fb[fbidx]))
                try_to_load(fbidx);
#endif /* CONFIG_KMOD */
        if (!(info = registered_fb[fbidx]))
                return -ENODEV;
        if (!try_module_get(info->fbops->owner))
                return -ENODEV;
        if (info->fbops->fb_open) {
                res = info->fbops->fb_open(info,1);
                if (res)
                        module_put(info->fbops->owner);
        }
        return res;
}

This suddenly appeared in 2.5.66, 2.5.65 works flawlessly with the same
compiler.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
