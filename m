Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933733AbWKSXlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933733AbWKSXlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 18:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933778AbWKSXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 18:41:36 -0500
Received: from silene.metacarta.com ([65.77.47.18]:20417 "EHLO
	silene.metacarta.com") by vger.kernel.org with ESMTP
	id S933733AbWKSXlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 18:41:35 -0500
X-Auth-Received: from webmail.metacarta.com (cone-peak.metacarta.com [65.77.47.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by silene.metacarta.com (Postfix) with ESMTP id B8E9D14C830E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2006 18:41:33 -0500 (EST)
Message-ID: <51489.68.160.147.35.1163979693.squirrel@webmail.metacarta.com>
Date: Sun, 19 Nov 2006 18:41:33 -0500 (EST)
Subject: [PATCH] AF_UNIX recv/shutdown race
From: jmalicki@metacarta.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20061119184133_68207"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20061119184133_68207
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


On some of our systems (Linux 2.6, 4-way SMP), we have found a race where
occasionally recv() can detect a shutdown before the last bytes written to
the socket, and will exhibit the odd behavior where recv() will return 0
to indicate a shutdown socket, and a subsequent call will return the last
bit data, after which it will return 0 again.

This is demonstrated by the attached test cases (cli.c and srv.c).  Start
one srv and several cli processes (perhaps 4-8) on a 2x dual core P4 (most
likely other systems as well, but I haven't reproduced it on other
configurations), and you will soon see this behavior.

What happens is that in unix_stream_recvmsg, the system checks for any
skbuffs on the queue ready to return.  Meanwhile, immediately afterwards,
another process/processor writes an skbuff and shuts down the sock.  Our
original reader process then checks shutdown, and returns 0.  On the next
call, it finally sees the skbuff written.

This patch combines af_unix's unix_sk(sk).readlock with
unix_state_rlock/runlock(sk).  readlock was only ever used by bind,
autobind, and unix_{stream,dgram}_recvmsg.  I can't see any way of
ensuring correctness for unix_stream_recvmsg without forcing it to hold
the state lock across getting the skbuf and checking shutdown.


Signed-off-by: Joseph Malicki <joe.malicki@metacarta.com>
-------------------------------
diff -rup linux-2.6.18.orig/include/net/af_unix.h
linux-2.6.18/include/net/af_unix.h
--- linux-2.6.18.orig/include/net/af_unix.h	2006-09-19 23:42:06.000000000
-0400
+++ linux-2.6.18/include/net/af_unix.h	2006-10-02 19:42:07.000000000 -0400
@@ -78,7 +78,6 @@ struct unix_sock {
         struct unix_address     *addr;
         struct dentry		*dentry;
         struct vfsmount		*mnt;
-	struct mutex		readlock;
         struct sock		*peer;
         struct sock		*other;
         struct sock		*gc_tree;
diff -rup linux-2.6.18.orig/net/unix/af_unix.c
linux-2.6.18/net/unix/af_unix.c
--- linux-2.6.18.orig/net/unix/af_unix.c	2006-09-19 23:42:06.000000000
-0400 +++ linux-2.6.18/net/unix/af_unix.c	2006-10-06 15:28:44.000000000
-0400 @@ -50,6 +50,8 @@
  *	     Arnaldo C. Melo	:	Remove MOD_{INC,DEC}_USE_COUNT,
  *	     				the core infrastructure is doing that
  *	     				for all net proto families now (2.5.69+)
+ *	       Joseph Malicki	:	Fix SMP race between write/shutdown
+ *					and read.
  *
  *
  * Known differences from reference BSD that was tested:
@@ -593,7 +595,6 @@ static struct sock * unix_create1(struct
 	u->mnt	  = NULL;
 	spin_lock_init(&u->lock);
 	atomic_set(&u->inflight, sock ? 0 : -1);
-	mutex_init(&u->readlock); /* single task reading lock */
 	init_waitqueue_head(&u->peer_wait);
 	unix_insert_socket(unix_sockets_unbound, sk);
 out:
@@ -650,7 +651,7 @@ static int unix_autobind(struct socket *
 	struct unix_address * addr;
 	int err;

-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);

 	err = 0;
 	if (u->addr)
@@ -687,7 +688,7 @@ retry:
 	spin_unlock(&unix_table_lock);
 	err = 0;

-out:	mutex_unlock(&u->readlock);
+out:	unix_state_runlock(sk);
 	return err;
 }

@@ -770,7 +771,7 @@ static int unix_bind(struct socket *sock
 		goto out;
 	addr_len = err;

-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);

 	err = -EINVAL;
 	if (u->addr)
@@ -842,7 +843,7 @@ static int unix_bind(struct socket *sock
 out_unlock:
 	spin_unlock(&unix_table_lock);
 out_up:
-	mutex_unlock(&u->readlock);
+	unix_state_runlock(sk);
 out:
 	return err;

@@ -1572,7 +1573,7 @@ static int unix_dgram_recvmsg(struct kio

 	msg->msg_namelen = 0;

-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);

 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
@@ -1628,7 +1629,7 @@ static int unix_dgram_recvmsg(struct kio
 out_free:
 	skb_free_datagram(sk,skb);
 out_unlock:
-	mutex_unlock(&u->readlock);
+	unix_state_runlock(sk);
 out:
 	return err;
 }
@@ -1674,7 +1675,6 @@ static int unix_stream_recvmsg(struct ki
 	struct sock_iocb *siocb = kiocb_to_siocb(iocb);
 	struct scm_cookie tmp_scm;
 	struct sock *sk = sock->sk;
-	struct unix_sock *u = unix_sk(sk);
 	struct sockaddr_un *sunaddr=msg->msg_name;
 	int copied = 0;
 	int check_creds = 0;
@@ -1704,7 +1704,7 @@ static int unix_stream_recvmsg(struct ki
 		memset(&tmp_scm, 0, sizeof(tmp_scm));
 	}

-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);

 	do
 	{
@@ -1728,7 +1728,7 @@ static int unix_stream_recvmsg(struct ki
 			err = -EAGAIN;
 			if (!timeo)
 				break;
-			mutex_unlock(&u->readlock);
+			unix_state_runlock(sk);

 			timeo = unix_stream_data_wait(sk, timeo);

@@ -1736,7 +1736,7 @@ static int unix_stream_recvmsg(struct ki
 				err = sock_intr_errno(timeo);
 				goto out;
 			}
-			mutex_lock(&u->readlock);
+			unix_state_rlock(sk);
 			continue;
 		}

@@ -1802,7 +1802,7 @@ static int unix_stream_recvmsg(struct ki
 		}
 	} while (size);

-	mutex_unlock(&u->readlock);
+	unix_state_runlock(sk);
 	scm_recv(sock, msg, siocb->scm, flags);
 out:
 	return copied ? : err;



------=_20061119184133_68207
Content-Type: text/plain; name="af_unix_readshutdownrace.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="af_unix_readshutdownrace.diff"

diff -rup linux-2.6.18.orig/include/net/af_unix.h linux-2.6.18/include/net/af_unix.h
--- linux-2.6.18.orig/include/net/af_unix.h	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18/include/net/af_unix.h	2006-10-02 19:42:07.000000000 -0400
@@ -78,7 +78,6 @@ struct unix_sock {
         struct unix_address     *addr;
         struct dentry		*dentry;
         struct vfsmount		*mnt;
-	struct mutex		readlock;
         struct sock		*peer;
         struct sock		*other;
         struct sock		*gc_tree;
diff -rup linux-2.6.18.orig/net/unix/af_unix.c linux-2.6.18/net/unix/af_unix.c
--- linux-2.6.18.orig/net/unix/af_unix.c	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18/net/unix/af_unix.c	2006-10-06 15:28:44.000000000 -0400
@@ -50,6 +50,8 @@
  *	     Arnaldo C. Melo	:	Remove MOD_{INC,DEC}_USE_COUNT,
  *	     				the core infrastructure is doing that
  *	     				for all net proto families now (2.5.69+)
+ *	       Joseph Malicki	:	Fix SMP race between write/shutdown
+ *					and read.
  *
  *
  * Known differences from reference BSD that was tested:
@@ -593,7 +595,6 @@ static struct sock * unix_create1(struct
 	u->mnt	  = NULL;
 	spin_lock_init(&u->lock);
 	atomic_set(&u->inflight, sock ? 0 : -1);
-	mutex_init(&u->readlock); /* single task reading lock */
 	init_waitqueue_head(&u->peer_wait);
 	unix_insert_socket(unix_sockets_unbound, sk);
 out:
@@ -650,7 +651,7 @@ static int unix_autobind(struct socket *
 	struct unix_address * addr;
 	int err;
 
-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);
 
 	err = 0;
 	if (u->addr)
@@ -687,7 +688,7 @@ retry:
 	spin_unlock(&unix_table_lock);
 	err = 0;
 
-out:	mutex_unlock(&u->readlock);
+out:	unix_state_runlock(sk);
 	return err;
 }
 
@@ -770,7 +771,7 @@ static int unix_bind(struct socket *sock
 		goto out;
 	addr_len = err;
 
-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);
 
 	err = -EINVAL;
 	if (u->addr)
@@ -842,7 +843,7 @@ static int unix_bind(struct socket *sock
 out_unlock:
 	spin_unlock(&unix_table_lock);
 out_up:
-	mutex_unlock(&u->readlock);
+	unix_state_runlock(sk);
 out:
 	return err;
 
@@ -1572,7 +1573,7 @@ static int unix_dgram_recvmsg(struct kio
 
 	msg->msg_namelen = 0;
 
-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);
 
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
@@ -1628,7 +1629,7 @@ static int unix_dgram_recvmsg(struct kio
 out_free:
 	skb_free_datagram(sk,skb);
 out_unlock:
-	mutex_unlock(&u->readlock);
+	unix_state_runlock(sk);
 out:
 	return err;
 }
@@ -1674,7 +1675,6 @@ static int unix_stream_recvmsg(struct ki
 	struct sock_iocb *siocb = kiocb_to_siocb(iocb);
 	struct scm_cookie tmp_scm;
 	struct sock *sk = sock->sk;
-	struct unix_sock *u = unix_sk(sk);
 	struct sockaddr_un *sunaddr=msg->msg_name;
 	int copied = 0;
 	int check_creds = 0;
@@ -1704,7 +1704,7 @@ static int unix_stream_recvmsg(struct ki
 		memset(&tmp_scm, 0, sizeof(tmp_scm));
 	}
 
-	mutex_lock(&u->readlock);
+	unix_state_rlock(sk);
 
 	do
 	{
@@ -1728,7 +1728,7 @@ static int unix_stream_recvmsg(struct ki
 			err = -EAGAIN;
 			if (!timeo)
 				break;
-			mutex_unlock(&u->readlock);
+			unix_state_runlock(sk);
 
 			timeo = unix_stream_data_wait(sk, timeo);
 
@@ -1736,7 +1736,7 @@ static int unix_stream_recvmsg(struct ki
 				err = sock_intr_errno(timeo);
 				goto out;
 			}
-			mutex_lock(&u->readlock);
+			unix_state_rlock(sk);
 			continue;
 		}
 
@@ -1802,7 +1802,7 @@ static int unix_stream_recvmsg(struct ki
 		}
 	} while (size);
 
-	mutex_unlock(&u->readlock);
+	unix_state_runlock(sk);
 	scm_recv(sock, msg, siocb->scm, flags);
 out:
 	return copied ? : err;
------=_20061119184133_68207
Content-Type: text/x-csrc; name="cli.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="cli.c"

/* a client in the unix domain */
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
  int conn;
  struct sockaddr_un  serv_addr;

  char buffer[4];
  int  len;
   
  while( 1 ) {  
    bzero((char *)&serv_addr,sizeof(serv_addr));
    serv_addr.sun_family = AF_UNIX;
    strcpy(serv_addr.sun_path, "/tmp/ugh");
    
    conn = socket(AF_UNIX, SOCK_STREAM,0);
    if( conn < 0 ) {
      perror( "couldn't create socket" );
      return -1;
    }
    
    if( connect( conn, (struct sockaddr *)&serv_addr,
                 strlen(serv_addr.sun_path) + sizeof(serv_addr.sun_family) ) < 0 ) {
      perror( "couldn't connect" );
      return -1; 
    }
    
    bzero(buffer, 4);
    len = recv(conn,buffer,3,MSG_WAITALL);
    if( len != 3 ) {
      perror( "eh?" );
      printf( "HUH: %d\n", len );
      len = recv(conn,buffer,3,MSG_WAITALL);
      if( len == 3 ) {
        printf( "WTF: %d, %s\n", len, buffer );
      }
      return -1;
    }
    else {
      printf( "%s\n", buffer );
    }
    shutdown(conn,2);
    close(conn);
  }

   return 0;
}
------=_20061119184133_68207
Content-Type: text/x-csrc; name="srv.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="srv.c"

/* a server in the unix domain.  The pathname of 
   the socket address is passed as an argument */
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
  int listener;
  struct sockaddr_un serv_addr;
  int len;
  int conn;
  
  listener = socket(AF_UNIX,SOCK_STREAM,0);
  if( listener < 0 ) {
    perror( "couldn't create socket" );
    return -1;
  }


  bzero( (char *)&serv_addr, sizeof(serv_addr) );
  serv_addr.sun_family = AF_UNIX;
  unlink( "/tmp/ugh" );
  strcpy( serv_addr.sun_path, "/tmp/ugh" );
  
  if( bind( listener, (struct sockaddr *)&serv_addr,
            strlen(serv_addr.sun_path) + sizeof(serv_addr.sun_family) ) < 0 ) {
    perror( "bind failed" );
    return -1;         
  }

  listen( listener, 0 );
  
  while( 1 ) {
    conn = accept( listener, NULL, NULL );
    if( conn < 0 ) {
      perror( "accept() failed" );
      return -1;
    }
    len = write( conn, "one", 3 );
    if(len != 3) {
	    printf("short write: %d!\n", len);
    }
    shutdown( conn, 2 );
    close( conn );
  }
  
  return 0;
}
------=_20061119184133_68207--


