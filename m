Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTHYITL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTHYITL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:19:11 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:43214 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261214AbTHYITA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:19:00 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Personnal line discipline difficulties
Date: Mon, 25 Aug 2003 10:18:58 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308251018.58127.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please be kind to advise me if I don't post on the right mailing-list.

I'm trying to implement a driver to a specific network peripherial (not 
commercial) ; this peripherial uses both parallel and serial ports to connect 
to one PC. I've succeeded in managing the parallel port, but the serial one 
still raises some difficulties (yet, I've used Linux Device Drivers book from 
Rubini, I've looked sources of bluetooth and n_tty drivers, searched Internet 
and eventually asked on kernelnewbies mailing-list with no solution).

My serial involved module code is :
        int ccsds_sport_ldisc_attach(struct tty_struct *tty) {
               return 0;
        }

        void ccsds_sport_ldisc_detach(struct tty_struct *tty) {
                return;
        }

        void ccsds_sport_receive_buf(struct tty_struct *tty, const unsigned 
char *cp, char *fp, int count) {
                struct sk_buff *skb;
                int i;

               skb = dev_alloc_skb(count);
                if (!skb) {
                        printk("<4>low memory\n");
                        return;
                }
                memcpy(skb_put(skb, count), cp, count);
                printk("<7>Size = %i\n", count);
                printk("<7>Data : ");
                for (i=0; i<count; i++)
                        printk(" %.2X(%2X)",*(cp+i), *(fp+i));
                printk("\n");
                return;
        }

        int ccsds_sport_ldisc_receive_room(struct tty_struct *tty) {
                return 248;	/* Hardware property */
        }

        struct tty_ldisc sport_ldisc= {
                magic : TTY_LDISC_MAGIC,
                name : "ccsds_sport_ldisc",
                flags : 0,
                open : ccsds_sport_ldisc_attach,
                close : ccsds_sport_ldisc_detach,
                receive_buf : ccsds_sport_receive_buf,
                receive_room : ccsds_sport_ldisc_receive_room,
        };
and call of
        result=tty_register_ldisc(N_TTY, &sport_ldisc); 
in module_init (which returns no error).

To activate the line discipline, I use a modified version of the kirkrun from 
Rubini :
        int configure(int fd, int toggle)
        {
            struct termios newTermIo;
            unsigned int bits;
            if (toggle) {
                /* First of all, toggle RTS and DTR */
                if (ioctl(fd,TIOCMGET,&bits)) return -1;
                bits &= ~(TIOCM_RTS | TIOCM_DTR);
                if (ioctl(fd,TIOCMSET,&bits)) return -1;
                usleep(300*1000); bits |= (TIOCM_RTS | TIOCM_DTR);
                if (ioctl(fd,TIOCMSET,&bits)) return -1;
                usleep(300*1000);
            }
            memset(&newTermIo, 0, sizeof(struct termios));
            newTermIo.c_iflag = IGNBRK  |IGNPAR;
            newTermIo.c_oflag = 0;
            newTermIo.c_cflag = CS8 | CREAD | HUPCL | CLOCAL | CRTSCTS;
            newTermIo.c_lflag = 0;
            newTermIo.c_cc[VMIN] = 1;
            newTermIo.c_cc[VTIME] = 0;
            if (cfsetispeed(&newTermIo, B115200) < 0)
                return -1;
            if (tcsetattr(fd, TCSANOW, &newTermIo) < 0)
                return -1;
            tcflush(fd, TCIOFLUSH);
            fcntl(fd, F_SETFL, 0); /* clear ndelay */
            return 0;
        }
        
        int main(int argc, char **argv)
        {
            int fd, i;
        
            if (argc != 2) {
                fprintf(stderr, "%s: Use \"%s <dev>\"\n", argv[0], argv[0]);
                exit(1);
            }
            if( (fd=open(argv[1], O_RDWR  | O_NOCTTY | O_NDELAY)) == -1){
                fprintf(stderr, "%s: %s: %s\n", argv[0], argv[1], 
strerror(errno));
                exit(1);
            }
            configure(fd,0);
            close(fd);
            if ((fd=open(argv[1], O_RDWR  | O_NOCTTY | O_NDELAY)) == -1){
               fprintf(stderr, "%s: %s: %s\n", argv[0], argv[1], 
strerror(errno));
                exit(1);
            }
            configure(fd,1);
            i = N_TTY;
            ioctl(fd, TIOCSETD, &i);
            while (1) sleep(INT_MAX);
            exit(0);
        }

I tried my driver with 
        echo 123456789 > /dev/ttyS0
from another PC (with the same line parameters according to setserial), but 
the result is not constant : sometimes, the line discipline receive the 11 
caracters (including the 0D and 0A termination), but most of the time, it 
receive firstly 8 the 3 caracters. The *fp value is always 0 (so there's no 
error !).
Following a piece of advice from kernelnewbies mailing-list, I've used minicom 
for testing, but the result is worst : I receiva each time only 1 caracter 
(99% of time FF), and there's still a zero value of *fp.

The fact is that I do need to receive an accurate count of emitted caracters 
(since the protocol used doesn't carry the size of PDU).

Does anyone know what I've fogotten in the line discipline ?
Thanks in advance,
-- 
Laurent Hugé.

