Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136616AbREGTBB>; Mon, 7 May 2001 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136614AbREGTA4>; Mon, 7 May 2001 15:00:56 -0400
Received: from [212.115.175.146] ([212.115.175.146]:26363 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S136611AbREGTA3>; Mon, 7 May 2001 15:00:29 -0400
Message-ID: <27525795B28BD311B28D00500481B76022A61C@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: /dev/random - having a (trivial) coding problem
Date: Mon, 7 May 2001 21:00:12 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See this program:

int main(int argc, char *argv[])
{
        int h;
        char buffer[16];
        int nbytes=16,nbits=16*8;
        int nin;

        h=open("/dev/random", O_RDONLY);
        if (h==-1) exit(1);

        /* see how many bits there are in it */
        printf("returned: %d\n", ioctl(h, RNDGETENTCNT, &nin));
        printf("current number of bits: %d\n", nin);

        /* add some */
        printf("returned: %d\n", ioctl(h, RNDADDENTROPY, buffer, (int
*)&nbits, (int *)&nbytes));

        /* see it it succeeded */
        printf("returned: %d\n", ioctl(h, RNDGETENTCNT, &nin));
        printf("current number of bits: %d\n", nin);

return 0;
}

it always fails!
But if I read the code for /dev/random correctly:
        case RNDADDENTROPY:
                if (!capable(CAP_SYS_ADMIN))
                        return -EPERM;
                p = (int *) arg;
                if (get_user(ent_count, p++))
                        return -EFAULT;
                if (ent_count < 0)
                        return -EINVAL;
                if (get_user(size, p++))
                        return -EFAULT;
                retval = random_write(file, (const char *) p,
                                      size, &file->f_pos);
                if (retval < 0)
                        return retval;
                credit_entropy_store(random_state, ent_count);

I did the right thing.
Didn't I? Aren't the ioctl-parameters in this case pointer to int, pointer
to int (ent_count) and another (to size)?
