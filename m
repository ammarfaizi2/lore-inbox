Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293503AbSCSCCz>; Mon, 18 Mar 2002 21:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293513AbSCSCCq>; Mon, 18 Mar 2002 21:02:46 -0500
Received: from bitmover.com ([192.132.92.2]:29334 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293503AbSCSCCe>;
	Mon, 18 Mar 2002 21:02:34 -0500
Date: Mon, 18 Mar 2002 18:02:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@suse.de>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020318180233.D10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@suse.de>, Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 12:22:41AM +0100, Dave Jones wrote:
> On Tue, Mar 19, 2002 at 12:14:28AM +0100, Pavel Machek wrote:
> 
>  > > Pavel, the problem here is your fundamental distrust.  
>  > By giving me binary-only installer you ask me to trust you. You ask me
>  > to trust you without good reason [it only generates .tar.gz and
>  > shellscript, why should it be binary? Was not shar designed to handle
>  > that?], and that's pretty suspect.
> 
>  Bitmover doing anything remotely suspect in an executable installer
>  would be commercial suicide, do you distrust realplayer too?

And all our installer does, and I will give you the code if you want it,
I'd be happy to even have Pavel audit it, is make two arrays, 

extern unsigned int installer_size;
extern unsigned char installer_data[];
extern unsigned int data_size;
extern unsigned char data_data[];

which we do some magic on to make sure they are preallocated (HPUX decided
that static global data should be allocated and bzeroed at runtime, so
we preinitialize them with garbage if I remember correctly).

Then the thing that makes the installer mmaps the object, looks for these
arrays (we stick some magic numbers in front of them), and files them in
with a .tar.gz and the real installer, which is a shell script.

The reason we didn't use shar, Pavel, is that we are shipping a binary.
If we used shar that would increase the size of the image that you download
and we wanted downloads to be fast.  As it is, I think it's a couple of MB.

Anyway, then the actual binary which runs is generated from the following 
program which is hardly worth all the fuss.

main()
{
        char    installer_name[200];
        char    data_name[200];
        char    cmd[2048];
        int     fd;

        fprintf(stderr, "Please wait while we unpack the installer...");
        sprintf(installer_name, "/tmp/installer%d", getpid());
        fd = creat(installer_name, 0777);
        if (fd == -1) {
                perror(installer_name);
                exit(1);
        }
        if (write(fd, installer_data, installer_size) != installer_size) {
                perror("write on installer");
                unlink(installer_name);
                exit(1);
        }
        close(fd);
        sprintf(data_name, "/tmp/data%d", getpid());
        fd = creat(data_name, 0777);
        if (fd == -1) {
                perror(data_name);
                exit(1);
        }
        sprintf(installer_name, "/tmp/installer%d", getpid());
        if (write(fd, data_data, data_size) != data_size) {
                perror("write on data");
                unlink(data_name);
                exit(1);
        }
        close(fd);
        fprintf(stderr, "done.\n");
        sprintf(cmd, "%s %s %s", installer_name, installer_name, data_name);
        system(cmd);
        exit(0);
}
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
