Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSLXDJU>; Mon, 23 Dec 2002 22:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbSLXDJU>; Mon, 23 Dec 2002 22:09:20 -0500
Received: from [196.12.44.6] ([196.12.44.6]:55940 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S267036AbSLXDJN>;
	Mon, 23 Dec 2002 22:09:13 -0500
Date: Tue, 24 Dec 2002 08:47:45 +0530 (IST)
From: Prasad <prasad_s@gdit.iiit.net>
X-X-Sender: prasad_s@students.iiit.net
To: Jelena Mirkovic <sunshine@CS.UCLA.EDU>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Create and send packet from kernel 
In-Reply-To: <Pine.SOL.4.33.0212231808170.18050-100000@panther.cs.ucla.edu>
Message-ID: <Pine.LNX.4.44.0212240844520.963-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The following is the code i once downloaded from the net... Apart from 
this one, the code of khttpd (linux/net/khttpd) would be very useful...

Go through thug_receive, thug_accept, thug_send, thug_listen... They 
should be sufficient for most of the networking...

Prasad
IIIT-Hyderabad, INDIA.

--------- START OF CODE ----------

 /*
  *
  *
  *                      Networking code for thug
  *
  *
  */


 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/malloc.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <asm/fcntl.h>
 #include <net/scm.h>
 #include <asm/uaccess.h>
 #include <linux/socket.h>
 #include <linux/inet.h>
 #include <asm/errno.h>

 #include "thugd.h"

 void fput(struct file *file);

 struct socket *socki_lookup(struct inode *inode)
 {
         return &inode->u.socket_i;
 }


 struct socket* thug_connect(struct sockaddr_in* sock_addr)
 {
         int retval;
         struct socket *sock;
        
         retval = sock_create(AF_INET,SOCK_STREAM,0,&sock);

         if (retval < 0) {
                 printk("thug_connect: error creating socket\n");
                 return NULL;
         }

         retval = sock->ops->connect(sock,(struct sockaddr *)sock_addr,sizeof(struct sockaddr_in),0);

         if (retval < 0) {
                 printk("thug_connect: error on connect: %d\n",retval);
                 sock_release(sock);
                 return NULL;
         }

         thug_print("Connection ok\n");

         return sock;
 }
        
 struct socket* thug_listen(void)
 {
         struct socket *sock;
         struct sockaddr_in servaddr;

         if (sock_create(AF_INET,SOCK_STREAM,0,&sock) < 0) {
                 printk("thug_listen: error creating socket\n");
                 return NULL;
         }

         memset(&servaddr,0,sizeof(servaddr));

         servaddr.sin_family = AF_INET;
         servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
         servaddr.sin_port = htons(THUG_PORT);

         if(sock->ops->bind(sock, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
                 printk("thug_listen: bind error\n");
                 sock_release(sock);
                 return NULL;
         }

         if (sock->ops->listen(sock,5) < 0) {
                 printk("thug_listen: listen error\n");
                 sock_release(sock);
                 return NULL;
         }

         return sock;
 }


 struct socket* thug_accept(struct socket* sock)
 {
         struct inode* inode;
         struct socket* newsock;
         int err;
         struct sockaddr_in sin;
         int slen;

         if (!(newsock = sock_alloc())) {
                 printk("thug_accept: error creating socket(2)\n");
                 return NULL;
         }

         inode = newsock->inode;
         newsock->type = sock->type;
         newsock->ops = sock->ops;

         /*if (sock->ops->dup(newsock,sock) < 0) {
                 printk("thug_accept: error dupping socket\n");
                 sock_release(newsock);
                 return NULL;
         }*/

         if ((err = newsock->ops->accept(sock,newsock,0)) < 0) {
                 sock_release(newsock);
                 return ERR_PTR(err);
         }

         slen = sizeof(sin);

         if ( (err = newsock->ops->getname(newsock,(struct sockaddr*)&sin,&slen,1)) < 0) {
                 printk("thug_accept: error on getname: %d\n",err);
                 sock_release(newsock);
                 return ERR_PTR(err);
         }

         newsock = socki_lookup(inode);

         return newsock;
 }

 int thug_receive(struct socket* sock,unsigned char* buf,int len)
 {
         struct msghdr msg;
         struct iovec iov;
         mm_segment_t oldfs;
         int size = 0;

         iov.iov_base = buf;
         iov.iov_len = len;

         msg.msg_iov = &iov;
         msg.msg_iovlen = 1;
         msg.msg_control = NULL;
         msg.msg_name = NULL;
         msg.msg_namelen = 0;

         oldfs = get_fs();
         set_fs(KERNEL_DS);
         size = sock_recvmsg(sock,&msg,len,0);
         set_fs(oldfs);

         if (size < 0)
                 printk("thug_read_from_socket: sock_recvmsg error: %d\n",size);

         return size;
 }


 int thug_read_from_socket(struct socket* sock,unsigned char* buf,int len)
 {
         int result;
         int received = 0;

         while(received < len) {
                 result = thug_receive(sock,buf + received,len - received);

                 if (result == 0)
                         return -EIO;
                 else if (result < 0)
                         return result;

                 received += result;
         }

         return received;
 }


 int thug_send(struct socket* sock,unsigned char* buf,int len)
 {
         struct msghdr msg;
         struct iovec iov;
         mm_segment_t oldfs;
         int size = 0;

         iov.iov_base = buf;
         iov.iov_len = len;

         msg.msg_iov = &iov;
         msg.msg_iovlen = 1;
         msg.msg_control = NULL;
         msg.msg_controllen = 0;
         msg.msg_name = NULL;
         msg.msg_namelen = 0;
         msg.msg_flags   = 0;

         oldfs = get_fs();
         set_fs(KERNEL_DS);
         size = sock_sendmsg(sock,&msg,len);
         set_fs(oldfs);
        
         if (size < 0)
                 printk("thug_write_to_socket: sock_sendmsg error: %d\n",size);

         return size;
 }

 int thug_write_to_socket(struct socket* sock,unsigned char* buf,int len)
 {
         int result;
         int sent = 0;

         while (sent < len) {
                 result = thug_send(sock,buf + sent,len - sent);

                 if (result == 0)
                         return -EIO;
                 else if (result < 0)
                         return result;

                 sent += result;
         }

         return sent;
 }


 int send_ack(struct socket* sock)
 {
         unsigned char buf = 0;

         if (thug_write_to_socket(sock,&buf,1) != 1) {
                 printk("Error sending ack");
                 return -1;
         }

         return 0;
 }


 int send_break(struct socket* sock)
 {
         unsigned char buf = 1;

         if (thug_write_to_socket(sock,&buf,1) != 1) {
                 printk("Error sending break");
                 return -1;
         }

         return 0;
 }


 int get_ack(struct socket* sock)
 {
         unsigned char buf;

         if (thug_read_from_socket(sock,&buf,1) != 1) {
                 printk("Error getting ack");
                 return -1;
         }

         if (buf != 0)
                 return -1;

         return 0;
 }


 void decodeui(unsigned int* dest,char* src)
 {      
         if (dest && src) {
                 *dest = 0;
                 *dest = (src[0] << 24) & 0xFF000000;
                 *dest |= (src[1] << 16) & 0xFF0000;
                 *dest |= (src[2] << 8) & 0xFF00;
                 *dest |= src[3] & 0xFF;
         }
 }

 void encodeui(char* dest,unsigned int src)
 {
         if (dest) {
                 dest[0] = (src & 0xFF000000) >> 24;
                 dest[1] = (src & 0xFF0000) >> 16;
                 dest[2] = (src & 0xFF00) >> 8;
                 dest[3] = src & 0xFF;
         }
 }

 void encodeus(char* dest,unsigned short src)
 {
         if (dest) {
                 dest[0] = (src & 0xFF00) >> 8;
                 dest[1] = src & 0xFF;
         }
 }


 void decodeus(unsigned short* dest,char* src)
 {
         if (dest && src) {
                 *dest = 0;
                 *dest = src[0] << 8;
                 *dest |= src[1] & 0xFF;
         }
 }

 void decodel(long* dest,char* src)
 {      
         if (dest && src) {
                 *dest = 0;
                 *dest = (src[0] << 24) & 0xFF000000;
                 *dest |= (src[1] << 16) & 0xFF0000;
                 *dest |= (src[2] << 8) & 0xFF00;
                 *dest |= src[3] & 0xFF;
         }
 }

 void encodel(char* dest,long src)
 {
         if (dest) {
                 dest[0] = (src & 0xFF000000) >> 24;
                 dest[1] = (src & 0xFF0000) >> 16;
                 dest[2] = (src & 0xFF00) >> 8;
                 dest[3] = src & 0xFF;
         }
 }


 void decodeul(unsigned long* dest,char* src)
 {      
         if (dest && src) {
                 *dest = 0;
                 *dest = (src[0] << 24) & 0xFF000000;
                 *dest |= (src[1] << 16) & 0xFF0000;
                 *dest |= (src[2] << 8) & 0xFF00;
                 *dest |= src[3] & 0xFF;
         }
 }

 void encodeul(char* dest,unsigned long src)
 {
         if (dest) {
                 dest[0] = (src & 0xFF000000) >> 24;
                 dest[1] = (src & 0xFF0000) >> 16;
                 dest[2] = (src & 0xFF00) >> 8;
                 dest[3] = src & 0xFF;
         }
 }


 void decodell(long long* dest,char* src)
 {
         if (dest && src) {
                 *dest = 0;
                 *dest  = (src[0] << 56) & 0xFF00000000000000;
                 *dest |= (src[1] << 48) & 0xFF000000000000;
                 *dest |= (src[2] << 40) & 0xFF0000000000;
                 *dest |= (src[3] << 32) & 0xFF00000000;
                 *dest |= (src[4] << 24) & 0xFF000000;
                 *dest |= (src[5] << 16) & 0xFF0000;
                 *dest |= (src[6] << 8)  & 0xFF00;
                 *dest |=  src[7]        & 0xFF;
         }
 }


 void encodell(char* dest,long long src)
 {
         if (dest) {
                 dest[0] = (src & 0xFF00000000000000) >> 56;
                 dest[1] = (src & 0x00FF000000000000) >> 48;
                 dest[2] = (src & 0x0000FF0000000000) >> 40;
                 dest[3] = (src & 0x000000FF00000000) >> 32;
                 dest[4] = (src & 0x00000000FF000000) >> 24;
                 dest[5] = (src & 0x0000000000FF0000) >> 16;
                 dest[6] = (src & 0x000000000000FF00) >> 8;
                 dest[7] =  src & 0x00000000000000FF;
         }
 }


 void decodei(int* dest,char* src)
 {      
         if (dest && src) {
                 *dest = 0;
                 *dest = (src[0] << 24) & 0xFF000000;
                 *dest |= (src[1] << 16) & 0xFF0000;
                 *dest |= (src[2] << 8) & 0xFF00;
                 *dest |= src[3] & 0xFF;
         }
 }


 void encodei(char* dest,int src)
 {
         if (dest) {
                 dest[0] = (src & 0xFF000000) >> 24;
                 dest[1] = (src & 0xFF0000) >> 16;
                 dest[2] = (src & 0xFF00) >> 8;
                 dest[3] = src & 0xFF;
         }
 }



 /* must be called with the socket locked */
 int thug_request(struct mfs_sb_info* thug_sb, unsigned int msglen)
 {
         unsigned short len;
         unsigned long flags;
         int error = 0;
         int mask;
         sigset_t old_set;

         spin_lock_irqsave(&current->sigmask_lock, flags);
         old_set = current->blocked;
         mask = sigmask(SIGKILL) | sigmask(SIGSTOP);
         siginitsetinv(&current->blocked,mask);
         recalc_sigpending(current);
         spin_unlock_irqrestore(&current->sigmask_lock, flags);

         if ((error = thug_write_to_socket(thug_sb->sock, thug_sb->packet, msglen)) != msglen) {
                 printk("thug_request: error sending request to server\n");
                 goto out;
         }

         memset(thug_sb->packet, 0, thug_sb->packet_len);

         if ((error = thug_read_from_socket(thug_sb->sock, thug_sb->packet, 2)) != 2) {
                 printk("thug_request: error reading reply length from socket\n");
                 goto out;
         }

         decodeus(&len, thug_sb->packet);

         if ((error = thug_read_from_socket(thug_sb->sock, thug_sb->packet + 2, len)) != len) {
                 printk("thug_request: error reading reply body from socket (%d)\n",len);
                 goto out;
         }

 out:
         spin_lock_irqsave(&current->sigmask_lock, flags);
         current->blocked = old_set;
         recalc_sigpending(current);
         spin_unlock_irqrestore(&current->sigmask_lock, flags);

         return error;
 }


 void encode_iattr(char* dest, struct iattr* attr)
 {
         encodeui(dest, attr->ia_valid);
         encodeus(dest + 4, attr->ia_mode);
         encodeui(dest + 6, attr->ia_uid);
         encodeui(dest + 10, attr->ia_gid);
         encodell(dest + 14, attr->ia_size);
         encodel(dest + 22, attr->ia_atime);
         encodel(dest + 26, attr->ia_mtime);
         encodel(dest + 30, attr->ia_ctime);
         encodeui(dest + 34, attr->ia_attr_flags);
 }

 void decode_iattr(struct iattr* dest, char* src)
 {
         decodeui(&dest->ia_valid, src);
         decodeus(&dest->ia_mode, src + 4);
         decodeui(&dest->ia_uid, src + 6);
         decodeui(&dest->ia_gid, src + 10);
         decodell(&dest->ia_size, src + 14);
         decodel(&dest->ia_atime, src + 22);
         decodel(&dest->ia_mtime, src + 26);
         decodel(&dest->ia_ctime, src + 30);
         decodeui(&dest->ia_attr_flags, src + 34);
 }

----------- END OF CODE ------------

On Mon, 23 Dec 2002, Jelena Mirkovic wrote:

> I am trying (in vain) to create and send a single TCP packet from kernel,
> from scratch (i.e. sk_buff and sock both need to be created and
> initialized). I read the source code for various functions in net and
> net/ipv4 but I am not sure I am doing all steps and in correct order, as
> the kernel keeps crashing. Is there a sample code someone could send me or
> a good book on this matter? I am using 2.4.9 version.
> 
> If this question is not appropriate for this list, could someone point me
> to more suitable list?
> 
> Thanks
> Jelena
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Failure is not an option

