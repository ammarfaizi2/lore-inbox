Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUIGSYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUIGSYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUIGSXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:23:22 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:22936 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268314AbUIGSSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:18:04 -0400
Date: Tue, 7 Sep 2004 21:16:41 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907181641.GB2154@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907151022.GA32287@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Tue, Sep 07, 2004 at 05:45:43PM +0300, Michael S. Tsirkin wrote:
> > > > > but I cannot think of a good alternative. 
> > > > > 
> > > > 
> > > > Maybe one entry point with a flag?
> > > 
> > > That would be IMHO far uglier than two. 
> > > 
> > > -Andi
> > >
> > 
> > What would be a good name? ioctl32/ioctl64? ioctl_compat/ioctl_native?
> 
> Later two sound ok to me.
> 

Wait, I think that a properly coded ioctl can always
figure out this is a compat call by looking at the command
(see example below).
So maybe we can live with just one new entry point with these
semantics?

MST

Example:

my_ioctl.h

//This structure size is different on 32 and 64 bit systems
struct my_foo {
  long foobar;
};

#define FOO _IOR(MY_MAGIC,0,struct my_foo)

//
my_ioctl.c

struct my_foo32 {
  int foobar;
};
#define FOO32 _IOR(MY_MAGIC,0,struct my_foo32)

static int ioctl_native (struct inode *inode, struct file *file, unsigned int
    opcode, unsigned long udata_l);
static int ioctl_compat (struct inode *inode, struct file *file, unsigned int
    opcode, unsigned long udata_l);

static int ioctl (struct inode *inode, struct file *file, unsigned int
    opcode, unsigned long udata_l)
{
  switch (opcode)
  {
    case FOO32:
      return ioctl_compat(inode,file,opcode,udata_l);
    case FOO:
    default:
      return ioctl_native(inode,file,opcode,udata_l);
  }
}

