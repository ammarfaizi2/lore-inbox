Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVCaTv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVCaTv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCaTv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:51:29 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:42064 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261675AbVCaTuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:50:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=mkSqEBoJ6QAvPs3sXlzIXpLaplKW8b0mAN1Qlx7apJ6qQ7upadTLYOm8JpYA6ZMESGbUZ3uJqEOac8bDZE3zJE0OXT1WpWo3mssCoAHDkNxDE9l5iK2dkxVoFRRfeGgjlUS4C6oweZES5/9sivKmF+rwulqRS18dH4RinrNnX5k=
Message-ID: <40f323d0050331115016b707f1@mail.gmail.com>
Date: Thu, 31 Mar 2005 14:50:37 -0500
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] Keys: Make request-key create an authorisation key
Cc: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <29760.1111611165@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1719_11416062.1112298637013"
References: <29204.1111608899@redhat.com> <29760.1111611165@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1719_11416062.1112298637013
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 23 Mar 2005 20:52:45 +0000, David Howells <dhowells@redhat.com> wrote:
> 
> The attached patch makes the following changes:
> 
>  (6) One of the process keyrings can be nominated as the default to which
>      request_key() should attach new keys if not otherwise specified. This is
>      done with KEYCTL_SET_REQKEY_KEYRING and one of the KEY_REQKEY_DEFL_*
>      constants. The current setting can also be read using this call.
> 
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> @@ -903,6 +922,44 @@ long keyctl_negate_key(key_serial_t id,
> 
>  /*****************************************************************************/
>  /*
> + * set the default keyring in which request_key() will cache keys
> + * - return the old setting
> + */
> +long keyctl_set_reqkey_keyring(int reqkey_defl)
> +{
> +       int ret;
> +
> +       switch (reqkey_defl) {
> +       case KEY_REQKEY_DEFL_THREAD_KEYRING:
> +               ret = install_thread_keyring(current);
> +               if (ret < 0)
> +                       return ret;
> +               goto set;
> +
> +       case KEY_REQKEY_DEFL_PROCESS_KEYRING:
> +               ret = install_process_keyring(current);
> +               if (ret < 0)
> +                       return ret;
> +
> +       case KEY_REQKEY_DEFL_DEFAULT:
> +       case KEY_REQKEY_DEFL_SESSION_KEYRING:
> +       case KEY_REQKEY_DEFL_USER_KEYRING:
> +       case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
> +       set:
> +               current->jit_keyring = reqkey_defl;
> +
> +       case KEY_REQKEY_DEFL_NO_CHANGE:
> +               return current->jit_keyring;
> +
> +       case KEY_SPEC_GROUP_KEYRING:

KEY_REQKEY_DEFL__GROUP_KEYRING

> +       default:
> +               return -EINVAL;
> +       }
> +
> +} /* end keyctl_set_reqkey_keyring() */
> +

> @@ -267,21 +294,84 @@ static struct key *request_key_construct
> 
>  /*****************************************************************************/
>  /*
> + * link a freshly minted key to an appropriate destination keyring
> + */
> +static void request_key_link(struct key *key, struct key *dest_keyring)
> +{
> +       struct task_struct *tsk = current;
> +       struct key *drop = NULL;
> +
> +       kenter("{%d},%p", key->serial, dest_keyring);
> +
> +       /* find the appropriate keyring */
> +       if (!dest_keyring) {
> +               switch (tsk->jit_keyring) {
> +               case KEY_REQKEY_DEFL_DEFAULT:
> +               case KEY_REQKEY_DEFL_THREAD_KEYRING:
> +                       dest_keyring = tsk->thread_keyring;
> +                       if (dest_keyring)
> +                               break;
> +
> +               case KEY_REQKEY_DEFL_PROCESS_KEYRING:
> +                       dest_keyring = tsk->signal->process_keyring;
> +                       if (dest_keyring)
> +                               break;
> +
> +               case KEY_REQKEY_DEFL_SESSION_KEYRING:
> +                       rcu_read_lock();
> +                       dest_keyring = key_get(
> +                               rcu_dereference(tsk->signal->session_keyring));
> +                       rcu_read_unlock();
> +                       drop = dest_keyring;
> +
> +                       if (dest_keyring)
> +                               break;
> +
> +               case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
> +                       dest_keyring = current->user->session_keyring;
> +                       break;
> +
> +               case KEY_REQKEY_DEFL_USER_KEYRING:
> +                       dest_keyring = current->user->uid_keyring;
> +                       break;
> +
> +               case KEY_REQKEY_DEFL_NO_CHANGE:

gcc-4 warns about this (warning: case label value is less than minimum
value for type) and it shouldn't be in jit_keyring anyway.

> +               case KEY_SPEC_GROUP_KEYRING:

KEY_REQKEY_DEFL_GROUP_KEYRING
> +               default:
> +                       BUG();
> +               }
> +       }
> +
> +       /* and attach the key to it */
> +       key_link(dest_keyring, key);

patch attached.

regards,

Benoit

------=_Part_1719_11416062.1112298637013
Content-Type: application/octet-stream; name="keys.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="keys.patch"

U2lnbmVkLU9mZi1CeTogQmVub2l0IEJvaXNzaW5vdCA8YmVub2l0LmJvaXNzaW5vdEBlbnMtbHlv
bi5vcmc+CgotLS0gLi9zZWN1cml0eS9rZXlzL3JlcXVlc3Rfa2V5LmMub3JpZwkyMDA1LTAzLTMx
IDIxOjIzOjQzLjAwMDAwMDAwMCArMDIwMAorKysgLi9zZWN1cml0eS9rZXlzL3JlcXVlc3Rfa2V5
LmMJMjAwNS0wMy0zMSAyMTo0MTowMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTMzNSw4ICszMzUsNyBA
QCBzdGF0aWMgdm9pZCByZXF1ZXN0X2tleV9saW5rKHN0cnVjdCBrZXkgCiAJCQlkZXN0X2tleXJp
bmcgPSBjdXJyZW50LT51c2VyLT51aWRfa2V5cmluZzsKIAkJCWJyZWFrOwogCi0JCWNhc2UgS0VZ
X1JFUUtFWV9ERUZMX05PX0NIQU5HRToKLQkJY2FzZSBLRVlfU1BFQ19HUk9VUF9LRVlSSU5HOgor
CQljYXNlIEtFWV9SRVFLRVlfREVGTF9HUk9VUF9LRVlSSU5HOgogCQlkZWZhdWx0OgogCQkJQlVH
KCk7CiAJCX0KLS0tIC4vc2VjdXJpdHkva2V5cy9rZXljdGwuYy5vcmlnCTIwMDUtMDMtMzEgMjE6
NDE6MzUuMDAwMDAwMDAwICswMjAwCisrKyAuL3NlY3VyaXR5L2tleXMva2V5Y3RsLmMJMjAwNS0w
My0zMSAyMTo0MjowMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTk1MSw3ICs5NTEsNyBAQCBsb25nIGtl
eWN0bF9zZXRfcmVxa2V5X2tleXJpbmcoaW50IHJlcWtlCiAJY2FzZSBLRVlfUkVRS0VZX0RFRkxf
Tk9fQ0hBTkdFOgogCQlyZXR1cm4gY3VycmVudC0+aml0X2tleXJpbmc7CiAKLQljYXNlIEtFWV9T
UEVDX0dST1VQX0tFWVJJTkc6CisJY2FzZSBLRVlfUkVRS0VZX0RFRkxfR1JPVVBfS0VZUklORzoK
IAlkZWZhdWx0OgogCQlyZXR1cm4gLUVJTlZBTDsKIAl9Cg==
------=_Part_1719_11416062.1112298637013--
