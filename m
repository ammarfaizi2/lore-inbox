Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319024AbSIJAKa>; Mon, 9 Sep 2002 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319026AbSIJAKa>; Mon, 9 Sep 2002 20:10:30 -0400
Received: from pompom.freestart.hu ([213.197.64.6]:41479 "EHLO
	pompom.freestart.hu") by vger.kernel.org with ESMTP
	id <S319024AbSIJAK2> convert rfc822-to-8bit; Mon, 9 Sep 2002 20:10:28 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Szombathelyi =?iso-8859-2?q?Gy=F6rgy?= <gyurco@freemail.hu>
To: linux-kernel@vger.kernel.org
Subject: CDROM_SEND_PACKET and ide-cd
Date: Tue, 10 Sep 2002 02:13:52 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209100213.52788.gyurco@freemail.hu>
X-Scanner: exiscan by Freestart
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on  a program that sends packets to cdrom devices. I'm using the 
CDROM_SEND_PACKET ioctl() to do it. The problem is when I specify the buffer 
length in cdrom_generic_command buflen field, all my ioctl calls are ends 
with EIO. So I can issue command only that not use a buffer (TEST UNIT READY, 
LOAD EJECT, etc) But this happens only with ide-cd, if I use the cdrom with 
ide-scsi and the scsi CD-ROM driver, it works. Here's a test program:

---------------------------------------------------
int main() {

struct cdrom_generic_command cgc;
struct request_sense sense;
char result[0x2c];
int fd;

if ((fd=open("/dev/hdc",O_RDONLY | O_NONBLOCK))<0) {
  fd=0;
  perror("Error opening device");
  exit(-1);
}
memset(&result,0,sizeof(result));
memset(&cgc, 0, sizeof(cgc));
memset(&sense, 0, sizeof(sense));

cgc.buffer=(void*) &result;
cgc.buflen=0x2c; //when it's 0 it works, but no data transfer
cgc.data_direction=CGC_DATA_READ;
cgc.timeout=HZ*12;
cgc.sense=&sense;

cgc.cmd[0] = 0x12; // INQUIRY
cgc.cmd[4] = 0x2c;

if (!ioctl(fd,CDROM_SEND_PACKET,&cgc)) {
  perror("Command ok\n");
  exit(0);
}

fprintf(stderr,"Error: %s code=%d\n",strerror(errno),errno);
fprintf(stderr,"Sense error code: %02x key:  %02x\n", 
sense.error_code,sense.sense_key);

}
---------------------------

So, where's the error? I couldn't find any other program that uses this ioctl 
(altough cd-writing programs should use it).  The above test program fails 
with EIO in the ioctl() call with ide-cd and works perfectly with ide-scsi 
and scsi cd driver (of course I replace /dev/hdc with /dev/sr0). (Sorry if I 
posted to the wrong list, but I didn't find better place)

Thanks for advance,
György Szombathelyi

