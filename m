Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWGKDS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWGKDS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWGKDS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:18:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:10715 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965087AbWGKDS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:18:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=h4ZS/fD1rbZ/a7jR9YSIHWQKC1XmNJlzXNaT9LicNFTT/Skf8NsKXJrz6MhQOTRejcbBnd9XW/TkM17fEY/qvjTQfTbtPOh2gPJTTMVxVLyVFwGI/2dE/tGODmCLSkNMM16L+iBvH3mRMittuVlg7AK5XX6DlmdVRAClGailCu4=
Message-ID: <489ecd0c0607102018k27890417mfdde8e112b22c48a@mail.gmail.com>
Date: Tue, 11 Jul 2006 11:18:24 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "David Miller" <davem@davemloft.net>, samuel@sortiz.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH]resend: unaligned access in irda protocol stack
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15987_9170374.1152587904533"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_15987_9170374.1152587904533
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

 I decided to regenerat and resend a whold patch for this:

 For "struct irda_device_info" in irda.h:
struct irda_device_info {
       __u32       saddr;    /* Address of local interface */
       __u32       daddr;    /* Address of remote device */
       char        info[22]; /* Description */
       __u8        charset;  /* Charset used for description */
       __u8        hints[2]; /* Hint bits */
};
  The "hints" member aligns at the third byte of a word, an odd
address. So if we visit "hints" as a short in irlmp.c and discorery.c:

   u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;

 will cause alignment problem on some machines. Architectures with
strict alignment rules do not allow 16-bit read on an odd address.

Signed-off-by: Luke Yang <luke.adi@gmail.com>
Acked-by: David Miller <davem@davemloft.net>

 discovery.c |    5 +++--
 irlmp.c     |    7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/irda/discovery.c b/net/irda/discovery.c
index 3fefc82..5ddf3e5 100644
--- a/net/irda/discovery.c
+++ b/net/irda/discovery.c
@@ -38,6 +38,7 @@ #include <net/irda/irda.h>
 #include <net/irda/irlmp.h>

 #include <net/irda/discovery.h>
+#include <asm/unaligned.h>

 /*
  * Function irlmp_add_discovery (cachelog, discovery)
@@ -86,7 +87,7 @@ void irlmp_add_discovery(hashbin_t *cach
                         */
                        hashbin_remove_this(cachelog, (irda_queue_t *) node);
                        /* Check if hints bits are unchanged */
-                       if(u16ho(node->data.hints) == u16ho(new->data.hints))
+                       if(get_unaligned(node->data.hints) ==
get_unaligned(new->data.hints))
                                /* Set time of first discovery for this node */
                                new->firststamp = node->firststamp;
                        kfree(node);
@@ -280,7 +281,7 @@ struct irda_device_info *irlmp_copy_disc
                /* Mask out the ones we don't want :
                 * We want to match the discovery mask, and to get only
                 * the most recent one (unless we want old ones) */
-               if ((u16ho(discovery->data.hints) & mask) &&
+               if ((get_unaligned(discovery->data.hints) & mask) &&
                    ((old_entries) ||
                     ((jiffies - discovery->firststamp) < j_timeout)) ) {
                        /* Create buffer as needed.
diff --git a/net/irda/irlmp.c b/net/irda/irlmp.c
index 129ad64..ee74f73 100644
--- a/net/irda/irlmp.c
+++ b/net/irda/irlmp.c
@@ -42,7 +42,6 @@ #include <net/irda/irlap.h>
 #include <net/irda/iriap.h>
 #include <net/irda/irlmp.h>
 #include <net/irda/irlmp_frame.h>
-
 #include <asm/unaligned.h>

 static __u8 irlmp_find_free_slsap(void);
@@ -1063,7 +1062,7 @@ void irlmp_discovery_expiry(discinfo_t *
                for(i = 0; i < number; i++) {
                        /* Check if we should notify client */
                        if ((client->expir_callback) &&
-                           (client->hint_mask.word & u16ho(expiries[i].hints)
+                           (client->hint_mask.word &
get_unaligned(expiries[i].hints)
                             & 0x7f7f) )
                                client->expir_callback(&(expiries[i]),
                                                       EXPIRY_TIMEOUT,
@@ -1083,11 +1082,13 @@ void irlmp_discovery_expiry(discinfo_t *
  */
 discovery_t *irlmp_get_discovery_response(void)
 {
+       __u16 *data_hintsp;
        IRDA_DEBUG(4, "%s()\n", __FUNCTION__);

        IRDA_ASSERT(irlmp != NULL, return NULL;);

-       u16ho(irlmp->discovery_rsp.data.hints) = irlmp->hints.word;
+       data_hintsp = (__u16 *) irlmp->discovery_rsp.data.hints;
+       put_unaligned(irlmp->hints.word, data_hintsp);

        /*
         *  Set character set for device name (we use ASCII), and


-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_15987_9170374.1152587904533
Content-Type: text/x-patch; name=irda_unaligned.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ephoztif
Content-Disposition: attachment; filename="irda_unaligned.patch"

ZGlmZiAtLWdpdCBhL25ldC9pcmRhL2Rpc2NvdmVyeS5jIGIvbmV0L2lyZGEvZGlzY292ZXJ5LmMK
aW5kZXggM2ZlZmM4Mi4uNWRkZjNlNSAxMDA2NDQKLS0tIGEvbmV0L2lyZGEvZGlzY292ZXJ5LmMK
KysrIGIvbmV0L2lyZGEvZGlzY292ZXJ5LmMKQEAgLTM4LDYgKzM4LDcgQEAgI2luY2x1ZGUgPG5l
dC9pcmRhL2lyZGEuaD4KICNpbmNsdWRlIDxuZXQvaXJkYS9pcmxtcC5oPgogCiAjaW5jbHVkZSA8
bmV0L2lyZGEvZGlzY292ZXJ5Lmg+CisjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPgogCiAvKgog
ICogRnVuY3Rpb24gaXJsbXBfYWRkX2Rpc2NvdmVyeSAoY2FjaGVsb2csIGRpc2NvdmVyeSkKQEAg
LTg2LDcgKzg3LDcgQEAgdm9pZCBpcmxtcF9hZGRfZGlzY292ZXJ5KGhhc2hiaW5fdCAqY2FjaAog
CQkJICovCiAJCQloYXNoYmluX3JlbW92ZV90aGlzKGNhY2hlbG9nLCAoaXJkYV9xdWV1ZV90ICop
IG5vZGUpOwogCQkJLyogQ2hlY2sgaWYgaGludHMgYml0cyBhcmUgdW5jaGFuZ2VkICovCi0JCQlp
Zih1MTZobyhub2RlLT5kYXRhLmhpbnRzKSA9PSB1MTZobyhuZXctPmRhdGEuaGludHMpKQorCQkJ
aWYoZ2V0X3VuYWxpZ25lZChub2RlLT5kYXRhLmhpbnRzKSA9PSBnZXRfdW5hbGlnbmVkKG5ldy0+
ZGF0YS5oaW50cykpCiAJCQkJLyogU2V0IHRpbWUgb2YgZmlyc3QgZGlzY292ZXJ5IGZvciB0aGlz
IG5vZGUgKi8KIAkJCQluZXctPmZpcnN0c3RhbXAgPSBub2RlLT5maXJzdHN0YW1wOwogCQkJa2Zy
ZWUobm9kZSk7CkBAIC0yODAsNyArMjgxLDcgQEAgc3RydWN0IGlyZGFfZGV2aWNlX2luZm8gKmly
bG1wX2NvcHlfZGlzYwogCQkvKiBNYXNrIG91dCB0aGUgb25lcyB3ZSBkb24ndCB3YW50IDoKIAkJ
ICogV2Ugd2FudCB0byBtYXRjaCB0aGUgZGlzY292ZXJ5IG1hc2ssIGFuZCB0byBnZXQgb25seQog
CQkgKiB0aGUgbW9zdCByZWNlbnQgb25lICh1bmxlc3Mgd2Ugd2FudCBvbGQgb25lcykgKi8KLQkJ
aWYgKCh1MTZobyhkaXNjb3ZlcnktPmRhdGEuaGludHMpICYgbWFzaykgJiYKKwkJaWYgKChnZXRf
dW5hbGlnbmVkKGRpc2NvdmVyeS0+ZGF0YS5oaW50cykgJiBtYXNrKSAmJgogCQkgICAgKChvbGRf
ZW50cmllcykgfHwKIAkJICAgICAoKGppZmZpZXMgLSBkaXNjb3ZlcnktPmZpcnN0c3RhbXApIDwg
al90aW1lb3V0KSkgKSB7CiAJCQkvKiBDcmVhdGUgYnVmZmVyIGFzIG5lZWRlZC4KZGlmZiAtLWdp
dCBhL25ldC9pcmRhL2lybG1wLmMgYi9uZXQvaXJkYS9pcmxtcC5jCmluZGV4IDEyOWFkNjQuLmVl
NzRmNzMgMTAwNjQ0Ci0tLSBhL25ldC9pcmRhL2lybG1wLmMKKysrIGIvbmV0L2lyZGEvaXJsbXAu
YwpAQCAtNDIsNyArNDIsNiBAQCAjaW5jbHVkZSA8bmV0L2lyZGEvaXJsYXAuaD4KICNpbmNsdWRl
IDxuZXQvaXJkYS9pcmlhcC5oPgogI2luY2x1ZGUgPG5ldC9pcmRhL2lybG1wLmg+CiAjaW5jbHVk
ZSA8bmV0L2lyZGEvaXJsbXBfZnJhbWUuaD4KLQogI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4K
IAogc3RhdGljIF9fdTggaXJsbXBfZmluZF9mcmVlX3Nsc2FwKHZvaWQpOwpAQCAtMTA2Myw3ICsx
MDYyLDcgQEAgdm9pZCBpcmxtcF9kaXNjb3ZlcnlfZXhwaXJ5KGRpc2NpbmZvX3QgKgogCQlmb3Io
aSA9IDA7IGkgPCBudW1iZXI7IGkrKykgewogCQkJLyogQ2hlY2sgaWYgd2Ugc2hvdWxkIG5vdGlm
eSBjbGllbnQgKi8KIAkJCWlmICgoY2xpZW50LT5leHBpcl9jYWxsYmFjaykgJiYKLQkJCSAgICAo
Y2xpZW50LT5oaW50X21hc2sud29yZCAmIHUxNmhvKGV4cGlyaWVzW2ldLmhpbnRzKQorCQkJICAg
IChjbGllbnQtPmhpbnRfbWFzay53b3JkICYgZ2V0X3VuYWxpZ25lZChleHBpcmllc1tpXS5oaW50
cykKIAkJCSAgICAgJiAweDdmN2YpICkKIAkJCQljbGllbnQtPmV4cGlyX2NhbGxiYWNrKCYoZXhw
aXJpZXNbaV0pLAogCQkJCQkJICAgICAgIEVYUElSWV9USU1FT1VULApAQCAtMTA4MywxMSArMTA4
MiwxMyBAQCB2b2lkIGlybG1wX2Rpc2NvdmVyeV9leHBpcnkoZGlzY2luZm9fdCAqCiAgKi8KIGRp
c2NvdmVyeV90ICppcmxtcF9nZXRfZGlzY292ZXJ5X3Jlc3BvbnNlKHZvaWQpCiB7CisJX191MTYg
KmRhdGFfaGludHNwOwogCUlSREFfREVCVUcoNCwgIiVzKClcbiIsIF9fRlVOQ1RJT05fXyk7CiAK
IAlJUkRBX0FTU0VSVChpcmxtcCAhPSBOVUxMLCByZXR1cm4gTlVMTDspOwogCi0JdTE2aG8oaXJs
bXAtPmRpc2NvdmVyeV9yc3AuZGF0YS5oaW50cykgPSBpcmxtcC0+aGludHMud29yZDsKKwlkYXRh
X2hpbnRzcCA9IChfX3UxNiAqKSBpcmxtcC0+ZGlzY292ZXJ5X3JzcC5kYXRhLmhpbnRzOworCXB1
dF91bmFsaWduZWQoaXJsbXAtPmhpbnRzLndvcmQsIGRhdGFfaGludHNwKTsKIAogCS8qCiAJICog
IFNldCBjaGFyYWN0ZXIgc2V0IGZvciBkZXZpY2UgbmFtZSAod2UgdXNlIEFTQ0lJKSwgYW5kCg==

------=_Part_15987_9170374.1152587904533--
